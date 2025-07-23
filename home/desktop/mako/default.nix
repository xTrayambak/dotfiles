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
			borderRadius = 16;
			layer = "overlay"; # make sure that fullscreen windows can't hide notifs
			font = "JetBrainsMono 11";
			defaultTimeout = 4000;
			borderSize = 2;
			markup = true;
			backgroundColor = "#0b0b0d66";
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
