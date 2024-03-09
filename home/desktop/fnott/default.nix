{ lib, ... }:
{
	services.fnott = customToINI {
		enable = true;
		settings = lib.generators.toINI {
			play-sound = "/home/tray/Sounds/notify.wav";
		};
	};
}
