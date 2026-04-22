{ pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.games.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    papers
    gnome-console
    gnome-text-editor
    gnome-contacts
    showtime
    rhythmbox
    decibels
    gnome-font-viewer
    gnome-system-monitor
    yelp
    baobab
    gnome-characters
    gnome-logs
    seahorse
    gnome-connections
    epiphany
  ];
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    rounded-window-corners-reborn
    paperwm
  ];
}
