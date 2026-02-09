{ pkgs, ... }:
{
  services.displayManager = {
    sddm = {
      enable = false;
      wayland.enable = false;
    };
  };

  services.desktopManager.plasma6 = {
    enable = false;
  };
}
