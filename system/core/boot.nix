{ lib, pkgs, ... }:

{
	boot = {
		bootspec.enable = true;

		initrd = {
			systemd.enable = true;
			supportedFilesystems = [ "ext4" ];
		};

		kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
		consoleLogLevel = 3;

		kernelParams = [
			"amd_iommu=on"
			"amd-pstate=active"
		];

		loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot.enable = true;
		};
	};
}
