{ pkgs, ... }:
{
	home.packages = with pkgs; [
		jetbrains-mono
	];
	programs.wezterm = {
		enable = true;
		enableZshIntegration = true;
		extraConfig = builtins.readFile ./wezterm.lua;
	};
}
