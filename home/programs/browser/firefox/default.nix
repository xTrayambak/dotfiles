{ pkgs, inputs, ... }:

{
  /*
    home.file."firefox-gnome-theme" = {
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
    	};
  */

  home.file."startpage-search" = {
    target = ".zen/";
  };
  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.system}.default;
    profiles = {
      default = {
        extraConfig = ''
          user_pref("browser.search.defaultenginename", "Startpage");
          user_pref("browser.search.selectedEngine", "Startpage");
                    	'';
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          i-dont-care-about-cookies
          sponsorblock
          return-youtube-dislikes
          windscribe
        ];
      };
    };
  };
}
