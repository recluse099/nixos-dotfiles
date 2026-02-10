{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rocq-core_9_1
  ];
}
