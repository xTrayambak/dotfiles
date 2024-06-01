{ lib, pkgs, config, ... }:

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
			"quiet"
			"splash"
			"amd_iommu=on"
			"kvm.ignore_msrs=1" 
			"video=efifb:off" 
			"vfio-pci.ids=1002:743f,1002:ab28"
		];

		loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot.enable = true;
		};
	};
}
