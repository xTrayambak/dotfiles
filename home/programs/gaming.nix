{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    steam
    wine-staging
    luanti
  ];
}
