{ pkgs, ... }:

{
	hardware.opengl = {
		enable = true;
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
