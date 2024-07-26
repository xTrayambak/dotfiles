{ pkgs, ... }:
{
	home.packages = with pkgs; [
		emacs29-pgtk
		tree-sitter
	];
	xdg.configFile = {
		"emacs/init.el".source = ./init.el;
    		# "emacs/config.org".source = ./config.org;
	};
}
