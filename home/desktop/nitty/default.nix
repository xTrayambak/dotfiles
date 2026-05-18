{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.nitty.packages.${pkgs.system}.default
  ];

  xdg.configFile.nitty = {
    enable = true;
    executable = false;
    force = true;
    source = ./configs;
    recursive = true;
  };
}
