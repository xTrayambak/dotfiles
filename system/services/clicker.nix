{ pkgs, ... }:
{
	systemd.services = {
		ydotoold = {
			enable = true;
			description = "RIP Mouse, thou shalt be missed";
			unitConfig = {
				Type = "simple";
			};
			serviceConfig = {
				ExecStart = "${pkgs.ydotool}/bin/ydotoold";
			};
			wantedBy = [ "multi-user.target" ];
		};
		clicker = {
			enable = true;
			after = [ "ydotoold.service" ];
			description = "RIP Mouse, thou shalt be missed";
			unitConfig = {
				Type = "simple";
			};
			serviceConfig = {
				ExecStart = "/usr/bin/wlclicker daemon ${pkgs.ydotool}/bin/ydotool";
			};
			wantedBy = [ "multi-user.target" ];
		};
	};
}
