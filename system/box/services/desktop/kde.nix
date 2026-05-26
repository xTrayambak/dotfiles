{ pkgs, ... }:
{
  /*
    services.displayManager = {
      plasma-login-manager.enable = false;
    };
  */

  services.desktopManager.plasma6 = {
    enable = false;
  };
}
