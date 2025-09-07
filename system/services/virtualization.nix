{ pkgs, ... }:
{
  # stolen from justin's dotfiles
  environment.systemPackages = with pkgs; [
    quickemu
  ];
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.docker.enable = true;
}
