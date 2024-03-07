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
		initExtra = ''
# I can't find a way to add these to my path automatically. Aw shucks.
export PATH="/home/$USER/.nimble/bin:$PATH"
		'';
	};
}

