{ pkgs, ... }:
{
	home.packages = with pkgs; [		
		(vesktop.override { withSystemVencord = false; })
	];

	xdg.configFile = {
		"vesktop/themes/theme.css".source = ./midnight-catpuccin-mocha.css;
	};
}
