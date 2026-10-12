# No physical access to grace to log in at the greeter, so this exposes
# recluse's niri session as a systemd service startable over SSH instead -
# gated by SSH key + sudo rather than a password typed at the console.
# Start with: sudo systemctl start niri-session, stop with:
# sudo systemctl stop niri-session.
#
# Runs on tty2, not tty1 (where greetd/the normal greeter lives), to avoid
# fighting greetd for the same VT.
#
# Root cause of the "VirtualTerminalAlreadyTaken" failures hit repeatedly
# while building this: NOT stale greeter sessions (a red herring - that
# looked plausible and even seemed to "fix" it a couple of times by luck).
# It's systemd-logind's auto-VT mechanism: any VT switch (even one it does
# itself as part of creating a session, no manual `chvt` needed to trigger
# it) can make logind spawn a getty on whichever VT was involved, entirely
# independent of the getty unit's enabled/disabled status. That getty then
# owns the VT's session slot and blocks a real login from claiming it.
# NAutoVTs=0 below disables this mechanism system-wide - both tty1 and tty2
# are already explicitly managed (by greetd and this unit respectively), so
# logind auto-spawning getties on either is never wanted here. Separately:
# creating a session on a given TTYPath does NOT itself switch the visible
# console - that needs an explicit `chvt` (see ExecStartPost/ExecStopPost).
{ pkgs, lib, ... }:
let
  # Pins DP-3 (the Dell U2724DE, see hosts/desktop/sunshine.nix) to the
  # laptop's 1920x1080@60 so Moonlight streaming doesn't mismatch resolution/
  # scale against the client display. Applied via `niri msg` at runtime only
  # (not written to the niri config), so a physical login through greetd
  # instead of this service still gets the monitor's native resolution.
  setRemoteOutput = pkgs.writeShellScript "set-remote-output" ''
    niri="${lib.getExe' pkgs.niri "niri"}"
    runtime_dir="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    # niri only sets NIRI_SOCKET for processes it spawns itself, not for a
    # separate systemd ExecStartPost - find the socket it created ourselves.
    for _ in $(seq 1 20); do
      sock=$(ls "$runtime_dir"/niri.wayland-*.sock 2>/dev/null | head -1)
      [ -n "$sock" ] && break
      sleep 0.5
    done
    export NIRI_SOCKET="$sock"
    "$niri" msg output DP-3 mode "1920x1080@60"
    "$niri" msg output DP-3 scale 1
  '';
in
{
  # Disables logind's auto-VT getty spawning entirely (see the note above) -
  # this is what was actually causing every "VirtualTerminalAlreadyTaken"
  # failure, on both tty1 and tty2.
  services.logind.settings.Login.NAutoVTs = 0;

  systemd.services.niri-session = {
    description = "On-demand niri session for recluse, started remotely over SSH";
    serviceConfig = {
      # One-time cleanup for a getty that may already be squatting on tty2
      # from earlier testing (before NAutoVTs=0 took effect) - harmless if
      # there isn't one.
      ExecStartPre = "-+${pkgs.systemd}/bin/systemctl stop getty@tty2.service";
      ExecStart = lib.getExe' pkgs.niri "niri-session";
      # logind does NOT switch the active/foreground console just from
      # creating a session on a given TTYPath - confirmed directly (session
      # correctly showed tty2, niri was running, but tty0/active stayed
      # tty1). Only DRM master (the foreground VT) actually renders/is
      # capturable by Sunshine, so this chvt is required, not optional - an
      # earlier version removed it based on a wrong read of an unrelated
      # failure (the getty@tty2 auto-spawn bug fixed by NAutoVTs= above).
      ExecStartPost = [
        "+${pkgs.kbd}/bin/chvt 2"
        "-${setRemoteOutput}" # "-": a failed resolution tweak shouldn't tear down an otherwise-working session.
      ];
      ExecStopPost = [
        # niri-session actually just launches systemd --user's niri.service
        # (decoupled cgroup), so stopping this unit alone leaves it orphaned -
        # stop it explicitly. Runs as recluse (this unit's User=).
        "${pkgs.systemd}/bin/systemctl --user stop niri.service"
        # Switch the visible console back to tty1 - greetd was never
        # stopped, so this alone makes the normal greeter visible again.
        "+${pkgs.kbd}/bin/chvt 1"
      ];
      User = "recluse";
      PAMName = "login";
      TTYPath = "/dev/tty2";
      # TTYReset/TTYVHangup/TTYVTDisallocate/StandardInput=tty are for a
      # genuinely interactive console login (agetty-style) that reads typed
      # input from the TTY - nothing types into tty2 here (this is triggered
      # over SSH, not console input), and binding this process to a
      # controlling terminal that way is a plausible source of the silent
      # ~10s deaths seen in testing (niri.service's own start job never even
      # appearing in its journal). PAMName+TTYPath alone should be enough for
      # the actual session/seat assignment.
      StandardOutput = "journal";
      StandardError = "journal";
      UtmpIdentifier = "tty2";
      Restart = "no";
    };
  };
}
