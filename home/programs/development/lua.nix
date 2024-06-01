{ pkgs, ... }:

{
	home.packages = with pkgs; [
		lualanguageserver
  	];
}
