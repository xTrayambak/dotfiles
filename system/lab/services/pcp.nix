{ pkgs, inputs, ... }:
{
  imports = [
    inputs.self.nixosModule.pcp
  ];

  services.pcp = {
    enable = true;
  };
}
