{ pkgs, ... }: {
	services.printing.enable = true;
	
	# Support for autodiscovery of network printers
	services.avahi = {
  		enable = true;
  		nssmdns4 = true;
  		openFirewall = true;
	};

	services.printing.drivers = with pkgs; [gutenprint hplip brlaser];
}
