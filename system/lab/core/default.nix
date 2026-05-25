{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./chores.nix
    ./security.nix
    ./users.nix
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
    systemPackages = [
      pkgs.vim
      pkgs.git
      pkgs.htop
      pkgs.duf
      pkgs.fastfetch
      inputs.agenix.packages.${pkgs.system}.default
    ];
    shellAliases = {
      "nix-switch" = "sudo nixos-rebuild switch --flake /etc/nixos#lab";
      "pull-conf" = "sudo git -C /etc/nixos pull origin master";
      "switch" = "pull-conf && nix-switch";
    };
  };

  system.stateVersion = lib.mkForce "25.11";
  time.timeZone = lib.mkDefault "Asia/Kolkata";
}
