{pkgs, ...}:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
    '';
    functions = {
      fish_prompt = "echo -n (starship prompt)";
       __starship_repaint_on_resize = {
         onSignal = "WINCH";
         body = "commandline -f repaint";
       };
    };
  };
}
    
