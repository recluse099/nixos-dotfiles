{
  systemd.services.disable-usb-mouse-wakeup = {
    description = "Disable USB mouse wakeup";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        # Disable wake on the USB device
        "/bin/sh -c 'echo disabled > /sys/bus/usb/devices/3-2/power/wakeup || true'"
      ];
    };
  };
}
