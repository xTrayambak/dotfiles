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
	imports = [ inputs.schizofox.homeManagerModule ];
	programs.firefox = {
		enable = true;
		package = pkgs.librewolf;
	};
	programs.schizofox = {
		enable = true;

		theme = {
			colors = {
				background-darker = "2e3440";
				background = "3b4252";
				foreground = "4c566a";
			};

			font = "JetBrainsMono";
		};

		search = {
			defaultSearchEngine = "Brave";
			removeEngines = [ "Google" "Bing" "Amazon.com" "eBay" "Twitter" ];
		};

		security = {
			sanitizeOnShutdown = false;
			sandbox = true;
			userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/123.0";
		};

		misc = {
			drmFix = true;
			disableWebgl = false;

			bookmarks = [
				{
					Title = "Nim Forum";
					URL = "https://forum.nim-lang.org";
					Placement = "toolbar";
					Folder = "Forums";
				}
				{
					Title = "Nix Forum";
					URL = "https://discourse.nixos.org";
					Placement = "toolbar";
					Folder = "Forums";
				},
				{
					Title = "Pastebin";
					URL = "https://bin.disroot.org/";
					Placement = "toolbar";
					Folder = "Utilities";
				}
			];
		};

		extensions = {
			extraExtensions = {
				"uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
			};
		};
	};
}
