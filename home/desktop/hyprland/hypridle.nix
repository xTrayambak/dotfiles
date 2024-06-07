{ pkgs, lib, inputs, config, ... }:
{
	services.hypridle.enable = true;
	services.hypridle.settings = {
		beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
		lockCmd = lib.getExe config.programs.hyprlock.package;

		listeners = [
			{
				timeout = 600;
				onTimeout = "${pkgs.avizo}/bin/lightctl 80\%";
			}
			{
				timeout = 900;
				onTimeout = "${pkgs.avizo}/bin/lightctl 60\%";
			}
			{
				timeout = 1100;
				onTimeout = "${pkgs.avizo}/bin/lightctl 20\%";
			}
			{
				timeout = 1800;
				onTimeout = "${pkgs.avizo}/bin/lightctl 0\%";
			}
		];
  	};
}
