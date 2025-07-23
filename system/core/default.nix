{ lib, pkgs, inputs, ... }:
{
	imports = [
		./boot.nix
		./security.nix
		./users.nix
#		./lanzaboote.nix
		./boot.nix
		./chores.nix
	];

	# Enable manpages for all users
	documentation = {
		dev.enable = true;
		man.generateCaches = true;
		nixos.includeAllModules = true;
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};
	
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	nixpkgs.config.allowUnfree = true;

	# Dconf
	programs.dconf.enable = true;
	
	# Enable zsh
	programs.zsh = {
		# Make sure that nothing can disable zsh or we're majestically screwed.
		enable = lib.mkForce true;
	};
	
	environment = {
		systemPackages = with pkgs; [
			libnotify
			xdg-utils
			polkit_gnome
			man-pages
			glib
			gsettings-desktop-schemas
			inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
			rose-pine-cursor
		];
		shellAliases = {};
	};

	# Nerd Fonts
	fonts.packages = with pkgs; [
		fira-code
		noto-fonts-cjk-sans
		noto-fonts
		noto-fonts-emoji
		font-awesome
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu
		nerd-fonts.zed-mono
		nerd-fonts.roboto-mono
	];

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
		config = {
			common.default = [ "gtk" ];
			hyprland.default = [ "gtk" "hyprland" ];
		};
		xdgOpenUsePortal = false;
 	};

	environment.variables = {
		GSK_RENDERER = "ngl"; # I have weird artifacting with the Vulkan backend on my GPU
	};

	services.flatpak.enable = true;

	system.stateVersion = lib.mkForce "24.05";
	time.timeZone = lib.mkDefault "Asia/Kolkata";
}
