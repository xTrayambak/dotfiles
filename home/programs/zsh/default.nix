{ config, ... }:

{
	programs.zsh = {
  		enable = true;
  		shellAliases = {
			phyton3 = "python3";
			phyton = "python3";

			nix-switch = "sudo nixos-rebuild switch --flake path:/home/${config.home.username}/.config/home-manager#box";
			hm-switch = "nix run /home/${config.home.username}/.config/home-manager -- switch";
			all-switch = "nix-switch && hm-switch";
			upgrade-flake = "ROLLBACK=$(pwd) cd /home/${config.home.username}/.config/home-manager && nix flake update && cd $ROLLBACK";
			neofetch = "fastfetch";
  		};
  		oh-my-zsh = {
    			enable = true;
    			plugins = [ "git" ];
    			theme = "robbyrussell";
  		};
		initExtra = ''
# I can't find a way to add these to my path with Nix. Aw shucks.
export PATH="/home/$USER/.nimble/bin:$PATH"
export SUDO_PROMPT="[] $USER: "
		'';
	};
}

