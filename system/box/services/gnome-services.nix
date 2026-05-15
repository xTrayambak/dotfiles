{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope (
        gfinal: gprev: {
          gvfs = gprev.gvfs.override {
            googleSupport = true;
            gnomeSupport = true;
          };
        }
      );
    })
  ];
  nixpkgs.config.permittedInsecurePackages = [ "libsoup-2.74.3" ];
  services = {
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;
}
