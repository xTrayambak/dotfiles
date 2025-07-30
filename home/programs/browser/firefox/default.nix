{ pkgs, inputs, ... }:

{
	/* home.file."firefox-gnome-theme" = {
		target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
		source = (
			fetchTarball {
				url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
				sha256 = "0hfhl2fd7wl5yrma8kf91xy40hd6vhygshsakg7drzbjs58hgbnj";
			}
		);
	};
	home.file."custom-firefox-css" = {
		target = ".mozilla/firefox/default/chrome/custom.css";
		source = ./custom.css;
	}; */
	programs.firefox = {
		enable = true;
		package = inputs.zen-browser.packages.${pkgs.system}.default;
		profiles = {
			default = {
				# GitHub keeps telling me to setup Deno or Node, so this is the only way to make it shut up.
				extraConfig = builtins.readFile ./userjsfile;
				/* userChrome = ''
					@import "firefox-gnome-theme/userChrome.css";
            				@import "firefox-gnome-theme/theme/colors/dark.css";
					@import "custom.css";
				''; */
				extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
					ublock-origin
					i-dont-care-about-cookies
					sponsorblock
					return-youtube-dislikes
					windscribe
					youtube-shorts-block
					decentraleyes
				];
			};
		};
	};
}
