{ pkgs, config, ... }:

{
	boot = {
		bootspec.enable = true;

		initrd = {
			systemd.enable = true;
			supportedFilesystems = [ "ext4" ];
		};

		kernelPackages = pkgs.linuxPackages_latest;
		consoleLogLevel = 3;

		kernelParams = [];

		loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot.enable = true;
		};
	};
}
