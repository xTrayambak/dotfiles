{
  pkgs,
  ...
}: 
{
	home.packages = with pkgs; [
		libnotify
	];
	services.mako = {
		enable = true;
		settings = {
			anchor = "top-center";
			border-radius = 16;
			layer = "overlay"; # make sure that fullscreen windows can't hide notifs
			font = "AdwaitaSans 11";
			default-timeout = 4000;
			border-size = 2;
			markup = true;
			background-color = "#0b0b0d66";
			height = 400;
			padding = "15,10,15";
			icons = true;
			width = 500;
		};
		extraConfig = ''
[urgency=normal]
border-color=#a3be8c

[urgency=low]
border-color=#a3be8c

[urgency=high]
border-color=#ee5353
default-timeout=0
'';
	};
}
