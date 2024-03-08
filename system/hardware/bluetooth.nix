# da bweututh devais iz redy 2 pea

{ pkgs, ... }:
{
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		package = pkgs.bluez;
		settings = {
			General = {
				Experimental = true;
			};
		};
	};

	environment.systemPackages = with pkgs; [ bluez bluez-tools ];
}
