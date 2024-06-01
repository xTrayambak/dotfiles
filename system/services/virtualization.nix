{ config, lib, pkgs, username, inputs, ... }:
{
  # stolen from justin's dotfiles
  environment.systemPackages = with pkgs; [
    virt-manager
    win-spice
    virtio-win
    quickemu
    spice-protocol
  ];
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
    };
  };
}
