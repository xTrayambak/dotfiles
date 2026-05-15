{ pkgs, ... }:
{
  # stolen from justin's dotfiles
  environment.systemPackages = with pkgs; [
    quickemu
    distrobox
  ];
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.docker.enable = true;
}
