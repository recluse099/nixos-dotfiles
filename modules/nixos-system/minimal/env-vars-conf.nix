{pkgs, lib, self, ...}:
{
  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = lib.getExe pkgs.ghostty;
  };
}
