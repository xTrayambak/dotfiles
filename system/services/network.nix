{
	networking = {
		networkmanager.enable = true;
		hostName = "box";

		nftables.enable = true;
		firewall = {
			enable = true;
			allowedTCPPorts = [ 80 443 ];
			allowedUDPPorts = [ ];
		};

		nameservers = [ "192.168.68.214" ];
	};
}
