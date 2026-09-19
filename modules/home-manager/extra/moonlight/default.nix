# Client for streaming grace's desktop (Sunshine host, see
# hosts/desktop/sunshine.nix) to this laptop over the network.
{ pkgs, ... }:
{
  home.packages = [ pkgs.moonlight-qt ];
}
