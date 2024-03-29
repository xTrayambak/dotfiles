{
  lib,
  config,
  pkgs,
  ...
}: 
{
	home.packages = with pkgs; [
		libnotify
	];
	services.mako = {
		enable = true;
		anchor = "top-right";
		borderRadius = 8;
		font = "JetBrainsMono 11";
		defaultTimeout = 4000;
		borderSize = 2;
		backgroundColor = "#1e1e2eff";
		extraConfig = ''
[urgency=normal]
border-color=#a3be8c

[urgency=low]
border-color=#b48ead

[urgency=high]
border-color=#bf616a
default-timeout=0
'';
	};
}
