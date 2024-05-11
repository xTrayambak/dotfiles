{ pkgs, ... }:
# haha touch gestures go brrrr
{
	services.fusuma = {
		enable = true;
		extraPackages = with pkgs; [ coreutils-full ];
		settings = {
			threshold = { swipe = 0.15; };
			interval = { swipe = 0.25; };
			swipe = {
				"4" = {
					left.command = "DISPLAY=0 ${pkgs.avizo}/bin/volumectl -u down";
					right.command = "DISPLAY=0 ${pkgs.avizo}/bin/volumectl -u up";

					up.command = "DISPLAY=0 ${pkgs.avizo}/bin/lightctl up";
					down.command = "DISPLAY=0 ${pkgs.avizo}/bin/lightctl down";
				};
			};
		};
	};
}
