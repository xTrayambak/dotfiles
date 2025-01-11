{ config, pkgs, ... }:
{
	programs.wlogout = {
		enable = true;
		layout = [
			{
				label = "Lock";
				action = "/home/${config.home.username}/.scripts/locker";
				text = "Lock";
				keybind = "l";
			}
			{
				label = "Logout";
				action = "hyprctl dispatch exit 0";
				text = "Logout";
				keybind = "e";
			}
			{
				label = "Suspend";
				action = "/home/${config.home.username}/.scripts/locker && ${pkgs.systemd}/bin/systemctl suspend";
				text = "Suspend";
				keybind = "s";
			}
			{
				label = "Shutdown";
				action = "${pkgs.systemd}/bin/systemctl poweroff";
				text = "Shutdown";
				keybind = "o";
			}
			{
				label = "Hibernate";
				action = "${pkgs.systemd}/bin/systemctl hibernate";
				text = "Hibernate";
				keybind = "h";
			}
			{
				label = "Reboot";
				action = "${pkgs.systemd}/bin/systemctl reboot";
				text = "Reboot";
				keybind = "r";
			}
		];
		style = builtins.readFile ./style.css;
	};
}
