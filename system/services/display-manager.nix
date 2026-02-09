{ inputs, pkgs, ... }:
{
  services.xserver.enable = false;
  services.displayManager = {
    enable = true;
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  /*
    environment.gnome.excludePackages = with pkgs; [
    		atomix
    		cheese
    		epiphany
    		evince
    		geary
    		gedit
    		gnome-characters
    		gnome-music
    		gnome-terminal
    		gnome-tour
    		totem
    	];

    	environment.systemPackages = with pkgs.gnomeExtensions; [
    		blur-my-shell
        	];
  */
}
