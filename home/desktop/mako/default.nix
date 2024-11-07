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
		anchor = "top-center";
		borderRadius = 8;
		layer = "overlay"; # make sure that fullscreen windows can't hide notifs
		font = "JetBrainsMono 11";
		defaultTimeout = 4000;
		borderSize = 2;
		backgroundColor = "#0b0b0d66";
		height = 400;
		width = 450;
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
