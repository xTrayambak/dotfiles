{ lib, pkgs, ... }:

{
	boot = {
		bootspec.enable = true;

		initrd = {
			systemd.enable = true;
			supportedFilesystems = [ "ext4" ];
			verbose = false;
		};

		kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
		consoleLogLevel = 0;

		kernelParams = [
			"amd_iommu=on"
			"amd-pstate=active"
			"quiet"
			"splash"
			"boot.shell_on_fail"
			"loglevel=3"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];

		loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot.enable = true;
		};

		plymouth = {
			enable = true;
			theme = "bgrt";
			themePackages = with pkgs; [
				nixos-bgrt-plymouth
			];
		};
	};
}
