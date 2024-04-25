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
					left.command = "${pkgs.avizo}/bin/volumectl -u down";
					right.command = "${pkgs.avizo}/bin/volumectl -u up";

					up.command = "${pkgs.avizo}/bin/lightctl up";
					down.command = "${pkgs.avizo}/bin/lightctl down";
				};
			};
		};
	};
}
