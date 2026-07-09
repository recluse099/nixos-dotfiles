{
  programs.swaylock = {
    enable = true;
    settings = {
      ignore-empty-password = true;
      show-failed-attempts = true;
      daemonize = true;

      image = "/home/recluse/dotfiles/modules/home-manager/wpaperd/wallpapers/dark-anime-aesthetic-desktop-wallpaper-1.jpg";
      scaling = "fill";

      indicator-idle-visible = false;
      indicator-radius = 120;
      indicator-thickness = 15;

      # idle ring is dark, key highlights are bright lavender — maximum contrast
      ring-color = "313244ff"; # Mocha surface0, dark
      ring-ver-color = "89b4faff"; # bright blue
      ring-wrong-color = "f38ba8ff"; # bright red
      ring-clear-color = "a6e3a1ff"; # bright green

      key-hl-color = "cdd6f4ff"; # bright white-ish text color, very visible against dark ring
      bs-hl-color = "f38ba8ff"; # bright red for backspace

      inside-color = "313244cc"; # surface0 — soft dark gray when idle
      inside-ver-color = "1e1e2ecc"; # base — darker when verifying, focused feel
      inside-wrong-color = "3b2a2acc"; # dark red tint — subtle error indication
      inside-clear-color = "1e2a1ecc"; # dark green tint — subtle success indication

      line-color = "cdd6f4ff"; # bright border between inside and ring
      line-ver-color = "89b4faff";
      line-wrong-color = "f38ba8ff";
      line-clear-color = "a6e3a1ff";

      text-color = "cdd6f4ff";
      text-ver-color = "89b4faff";
      text-wrong-color = "f38ba8ff";
      text-clear-color = "a6e3a1ff";

      text-caps-lock-color = "f9e2afff";
      indicator-caps-lock = true;

      separator-color = "00000000";

      font = "monospace";
      font-size = 14;
    };
  };
}
