{ ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      grace = {
        hostname = "grace.tail178f29.ts.net";
        user = "recluse";
        identityFile = "~/.ssh/id_ed25519_grace";
      };
    };
  };
}
