{ inputs, lib, pkgs, ... }:

{
	programs.zsh = {
  		enable = true;
  		shellAliases = {
			phyton3 = "python3";
			phyton = "python3";
  		};
  		oh-my-zsh = {
    			enable = true;
    			plugins = [ "git" ];
    			theme = "robbyrussell";
  		};
	};
}

