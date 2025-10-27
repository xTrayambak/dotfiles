{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../../scripts { })
  ];
}
