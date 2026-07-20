{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    waydroid
    waydroid-helper
  ];
}
