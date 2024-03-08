{ lib, pkgs, ... }:
{
	imports = [
		./boot.nix
		./security.nix
		./users.nix
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
			hm-switch = "nix run /home/tray/.config/home-manager#box -- switch";
			all-switch = "nix-switch && hm-switch";
			upgrade = "sudo nix flake update /home/tray/.config/home-manager# && all-switch";
		};
	};

	services.blueman.enable = true;

	# Nerd Fonts
  	fonts.packages = with pkgs; [
    		fira-code
    		noto-fonts-cjk-sans
    		noto-fonts
    		(nerdfonts.override {
      			fonts = [
        			"IBMPlexMono"
				"JetBrainsMono"
				"ProFont"
				"Ubuntu"
				"AnonymousPro"
				"RobotoMono"
      			];
    		})
  	];

  	xdg.portal = {
    		enable = true;
    		extraPortals = with pkgs; [
      			xdg-desktop-portal-gtk
     			xdg-desktop-portal-hyprland
    		];
    		config.common.default = "*";
 	};
	
	services.flatpak.enable = true;

	system.stateVersion = lib.mkDefault "24.05";
	time.timeZone = lib.mkDefault "Asia/Kolkata";
}
