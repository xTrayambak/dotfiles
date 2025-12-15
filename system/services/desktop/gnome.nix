{ config, pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.games.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    epiphany
  ];
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
  ];
}
