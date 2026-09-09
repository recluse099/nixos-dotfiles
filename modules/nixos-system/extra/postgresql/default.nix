{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "learning" ];
    ensureUsers = [
      {
        name = "learning";
        ensureDBOwnership = true;
      }
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
