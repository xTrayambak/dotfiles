{ config, pkgs, lib, ... }:
{
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
