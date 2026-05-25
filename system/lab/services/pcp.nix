{ pkgs, inputs, ... }:
{
  services.pcp = {
    enable = true;
  };
}
