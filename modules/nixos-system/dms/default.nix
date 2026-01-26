{pkgs, ...}:{
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
    enableSystemMonitoring = true; 
  };
}
