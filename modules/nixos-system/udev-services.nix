{ lib,... }:
{
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    # Disable USB device wakeups (mouse, USB HID)
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
    # Disable I2C HID device wakeups (touchpad)
    ACTION=="add", SUBSYSTEM=="i2c", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
  '';
}
