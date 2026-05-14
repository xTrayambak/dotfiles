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
    ];
    shellAliases = {
      "nix-switch" = "sudo nixos-rebuild switch --flake /etc/nixos#lab";
      "pull-conf" = "sudo git -C /etc/nixos pull origin refactor-1";
    };
  };

  system.stateVersion = lib.mkForce "25.11";
  time.timeZone = lib.mkDefault "Asia/Kolkata";
}
