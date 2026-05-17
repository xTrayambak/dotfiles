{ lib, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./users.nix
    ./chores.nix
  ];

  documentation = {
    dev.enable = false;
    man.cache.enable = false;
    nixos.includeAllModules = false;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enable = lib.mkForce true;

  security.polkit.enable = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      git
      htop
      duf
      fastfetch
    ];
    shellAliases = {
      "nix-switch" = "sudo nixos-rebuild switch --flake /etc/nixos#lab";
      "pull-conf" = "sudo git -C /etc/nixos pull origin";
    };
  };

  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the system console
    # to perform some lowlevel commands. It's a security concern and we do not require it.
    "kernel.sysrq" = 0;

    # TCP Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
    # both incoming and outgoing connections:
    "net.ipv4.tcp_fastopen" = 3;

    # cloudflared's quic-go dependency recommends setting the buffer
    # sizes to ~7.5 MB to prevent warnings and other errors.
    "net.core.rmem_max" = 7500000;
    "net.core.wmem_max" = 7500000;
  };

  system.stateVersion = lib.mkForce "25.11";
  time.timeZone = lib.mkDefault "Asia/Kolkata";
}
