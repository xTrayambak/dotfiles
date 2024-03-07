{ inputs, libs, pkgs, ... }:

{
	home.packages = with pkgs; [
		jetbrains-mono
	];
	programs.foot = {
        	enable = true;
        	server.enable = true;
        	settings = {
            		main = {
                		term = "xterm-256color";
                		font = "JetBrainsMono:size=12";
                		pad = "10x15 center";
                		dpi-aware = "no";
            		};
            		colors = {
                		alpha="0.4";
                		regular0="2e3440";  # black
                		regular1="bf616a";  # red
                		regular2="a3be8c";  # green
                		regular3="ebcb8b";  # yellow
                		regular4="5e81ac";  # blue
                		regular5="b48ead";  # magenta
                		regular6="81a1c1";  # cyan
                		regular7="d8dee9";  # white
                		bright0="4c566a";   # bright black
                		bright1="d08770";   # bright red
               			bright2="a3be8c";   # bright green
                		bright3="ebcb8b";   # bright yellow
                		bright4="8fbcbb";   # bright blue
                		bright5="b48ead";   # bright magenta
                		bright6="88c0d0";   # bright cyan
                		bright7="eceff4";   # bright white
            		};
            		tweak = {
                		sixel = "yes";
        		};
		};
	};
}
