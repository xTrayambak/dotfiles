{ lib, ... }:
{
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
	};

	# hardware.pulseaudio.enable = lib.mkForce false;
}
