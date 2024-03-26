{ pkgs, ... }:
{
	services = {
		dbus.packages = with pkgs; [
			gcr
			gnome.gnome-settings-daemon
		];

		gvfs.enable = true;
		gnome.gnome-keyring.enable = true;
	};

	security.pam.services.gdm.enableGnomeKeyring = true;
}
