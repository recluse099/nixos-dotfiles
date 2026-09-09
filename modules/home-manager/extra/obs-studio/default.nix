{pkgs, ...}:{
  programs.obs-studio = {
    enable = true;
  };
  home.packages = with pkgs; [ scrcpy android-tools]; # to cast and capture my tablet screen in obs
}
