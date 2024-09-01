{ pkgs, ... }:
{
	home.packages = with pkgs; [
		platformio
		arduino
	];
}
