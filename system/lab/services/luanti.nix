{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    luanti
  ];
}
