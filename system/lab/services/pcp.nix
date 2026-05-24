{ pkgs, inputs, ... }:
{
  imports = [
    inputs.pcp.packages.${pkgs.system}.nixosModule
  ];

  services.pcp = {
    enable = true;
  };
}
