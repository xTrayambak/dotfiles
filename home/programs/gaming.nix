{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    mangohud
    wine-staging
  ];
}
