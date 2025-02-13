{ inputs, pkgs, ... }: {
	services.xserver = {
		enable = true;
		displayManager.gdm = {
			enable = true;
			wayland = true;
		};
		desktopManager.gnome = {
			enable = false;
		};
	};

	/* environment.gnome.excludePackages = with pkgs; [
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

	environment.systemPackages = with pkgs.gnomeExtensions; [
		blur-my-shell
    	]; */

	programs.hyprland = {
		enable = true;
    		package = inputs.hyprland.packages.${pkgs.system}.hyprland;
	};
}
