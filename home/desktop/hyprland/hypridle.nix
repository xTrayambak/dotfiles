{ pkgs, config, ... }: let
	timeout = 300;
in
{
	services.hypridle.enable = true;
	services.hypridle.settings = {

		general = {
			before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
			lock_cmd = "/home/${config.home.username}/.scripts/locker";
			ignore_dbus_inhibit = false;
			ignore_systemd_inhibit = false;
		};

		listener = [
			{
				timeout = timeout - 40;
				on-timeout = "${pkgs.avizo}/bin/lightctl 80\%";
				on-resume = "${pkgs.avizo}/bin/lightctl 100\%";
			}
			{
				timeout = timeout - 20;
				on-timeout = "${pkgs.avizo}/bin/lightctl 60\%";
				on-resume = "${pkgs.avizo}/bin/lightctl 100\%";
			}
			{
				timeout = timeout - 10;
				on-timeout = "${pkgs.avizo}/bin/lightctl 20\%";
				on-resume = "${pkgs.avizo}/bin/lightctl 100\%";
			}
			{
				inherit timeout;
				on-timeout = "${pkgs.avizo}/bin/lightctl 0\% && hyprctl dispatch dpms off";
				on-resume = "${pkgs.avizo}/bin/lightctl 100\% && hyprctl dispatch dpms on";
			}
			{
				timeout = timeout + 5;
				on-timeout = "${config.home.username}/.scripts/locker";
			}
			{
				timeout = timeout + 20;
				on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
			}
		];
  	};
}
