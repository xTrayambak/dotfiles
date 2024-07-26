{ pkgs, ... }:

{
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
		extraPackages = with pkgs; [
			libva
			vaapiVdpau
			libvdpau-va-gl
		];
		extraPackages32 = with pkgs; [
			vaapiVdpau
			libvdpau-va-gl
		];
	};
}
