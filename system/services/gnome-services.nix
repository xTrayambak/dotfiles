{ pkgs, ... }:
{
	services = {
		dbus.packages = with pkgs; [
			gcr
			gnome.gnome-settings-daemon
		];

		gnome.gnome-keyring.enable = true;
	};

	security.pam.services.gdm.enableGnomeKeyring = true;
}
