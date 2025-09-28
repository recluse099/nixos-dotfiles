{pkgs, lib, self, ...}:
{
  environment.variables = {
    #EDITOR = lib.getExe self.packages.${pkgs.system}.default;
  };
}
