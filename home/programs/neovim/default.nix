{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		nimlsp
	];
	programs.git.enable = true;
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		extraLuaConfig = builtins.readFile ./init.lua;
	};
}
