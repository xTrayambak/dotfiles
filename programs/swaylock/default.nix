{ pkgs, ...}:
{
	programs.swaylock = {
		enable = true;
		package = pkgs.swaylock-effects;
		settings = {
			daemonize = true;
			ignore-empty-password = true;
			font = "JetBrainsMono";
			font-size = 32;
			indicator-radius = 128;
			indicator-thickness = 16;
			inside-color = "ffffff00";
			key-hl-color = "3daee9";
			ring-color = "1d99f388";
			line-uses-ring = true;
			separator-color = "1d99f322";
			text-color = "ffffff";
			text-clear-color = "ffffff";
			text-caps-lock-color = "ffffff";
			effect-vignette = "0.5:0.5";
			fade-in = 0.2;
			clock = true;
			indicator = true;
			effect-blur = "8x8";
		};
	};
}
