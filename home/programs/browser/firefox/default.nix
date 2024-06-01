{ pkgs, lib, inputs, ... }:

{
	home.file."firefox-gnome-theme" = {
		target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
		source = (
			fetchTarball {
				url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
				sha256 = "1xxd40dv0z8bj29krbrvhqiy1z3ysynj205pac22yy7004f6wp3v";
			}
		);
	};
	programs.firefox = {
		enable = true;
		profiles = {
			default = {
				# GitHub keeps telling me to setup Deno or Node, so this is the only way to make it shut up.
				extraConfig = builtins.readFile ./userjsfile;
				userChrome = ''
					@import "firefox-gnome-theme/userChrome.css";
            				@import "firefox-gnome-theme/theme/colors/dark.css"; 
				'';
				extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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
