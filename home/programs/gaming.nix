{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    steam
    lutris
    wine-staging
    luanti
  ];
}
