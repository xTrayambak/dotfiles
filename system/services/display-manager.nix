{ inputs, pkgs, ... }: {
	services.xserver = {
		enable = true;
		displayManager.gdm = {
			enable = true;
			wayland = true;
		};
		desktopManager.gnome = {
			enable = true;
		};
	};

	environment.gnome.excludePackages = with pkgs; [
		atomix
		cheese
		epiphany
		evince
		geary
		gedit
		gnome-characters
		gnome-music
		gnome-terminal
		gnome-tour
		totem
	];

	programs.hyprland = {
		enable = true;
    		package = inputs.hyprland.packages.${pkgs.system}.hyprland;
	};
}
