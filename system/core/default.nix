{ lib, pkgs, ... }:
{
	imports = [
		./boot.nix
		./security.nix
		./users.nix
		./chores.nix
	];
	documentation.dev.enable = true;

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};

	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	# Dconf
	programs.dconf.enable = true;
	
	# Enable zsh
	programs.zsh = {
		# Make sure that nothing can disable zsh or we're majestically screwed.
		enable = lib.mkForce true;
		shellAliases = {
			gc = "git commit ";
			gcm = "git commit -m ";
			nix-switch = "sudo nixos-rebuild switch --flake path:/home/tray/.config/home-manager#box";
			hm-switch = "nix run /home/tray/.config/home-manager -- switch";
			all-switch = "nix-switch && hm-switch";
			upgrade = "sudo nix flake update /home/tray/.config/home-manager# && all-switch";
		};
	};
	
	# Blueman
	services.blueman.enable = true;

	environment.systemPackages = with pkgs; [
		libnotify
		xdg-utils
		clang
		gcc
		polkit
		polkit_gnome
		libclang
	];

	# Nerd Fonts
  	fonts.packages = with pkgs; [
    		fira-code
    		noto-fonts-cjk-sans
    		noto-fonts
		noto-fonts-emoji
    		(nerdfonts.override {
      			fonts = [
        			"IBMPlexMono"
				"JetBrainsMono"
				"ProFont"
				"Ubuntu"
				"AnonymousPro"
				"RobotoMono"
				"Iosevka"
      			];
    		})
  	];

  	xdg.portal = {
    		enable = true;
    		extraPortals = with pkgs; [
      			xdg-desktop-portal-gtk
     			xdg-desktop-portal-hyprland
    		];
		config = {
			common.default = [ "gtk" ];
			hyprland.default = [ "gtk" "hyprland" ];
		};
		xdgOpenUsePortal = true;
 	};

	services.flatpak.enable = true;

	system.stateVersion = lib.mkForce "24.05";
	time.timeZone = lib.mkDefault "Asia/Kolkata";
}
