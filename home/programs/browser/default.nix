{ pkgs, lib, inputs, ... }:

{
	home.file."firefox-gnome-theme" = {
		target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
		source = (
			fetchTarball {
				url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
				sha256 = "01adb28aym5gk90p57c18m96wbzv7367gw8ad830zc3ly045k040";
			}
		);
	};
	programs.firefox = {
		enable = true;
		profiles = {
			default = {
				extraConfig = builtins.readFile ./user.js;
				userChrome = ''
					@import "firefox-gnome-theme/userChrome.css";
            				@import "firefox-gnome-theme/theme/colors/dark.css"; 
				'';
				extensions = with pkgs.nur.repos.rycee.firefox-addons; [
					ublock-origin
					keepassxc-browser
					i-dont-care-about-cookies
					sponsorblock
					return-youtube-dislikes
					windscribe
					youtube-shorts-block
					notifier-for-github
					decentraleyes
				];
			};
		};
	};
}
