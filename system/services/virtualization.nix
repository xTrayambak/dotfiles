{ config, lib, pkgs, username, inputs, ... }:
{
  # stolen from justin's dotfiles
  environment.systemPackages = with pkgs; [
    virt-manager
    win-spice
    virtio-win
    quickemu
    spice-protocol
    podman-tui
    podman-compose
    distrobox
  ];
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
