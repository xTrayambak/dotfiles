{ pkgs, ... }:
{
	users.users.tray = {
		isNormalUser = true;
		extraGroups = [
			"wheel"
			"video"
			"libvirtd"
			"input"
			"networkmanager"
			"tray"
		];
		initialPassword = "deinemutteristlecker";
		shell = pkgs.zsh;
		packages = with pkgs; [
			wpa_supplicant
			wl-clipboard
			killall
		];
	};

	environment = {
		# Launch hyprland upon login (tty1 only)
		loginShellInit = ''
	  		[ "$TTY" = /dev/tty1 ] && Hyprland
		'';
		sessionVariables = {
			NIXOS_OZONE_WL = "1";
			SDL_VIDEODRIVER = "wayland";
			GDK_BACKEND = "wayland";
			QT_QPA_PLATFORM = "wayland";
		};
		variables = {
			EDITOR = "nvim";
		};
	};
}
