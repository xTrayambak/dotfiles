{
  networking = {
    networkmanager.enable = true;
    hostName = "box";

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        8080
      ];
      allowedUDPPorts = [ ];
      allowedTCPPortRanges = [
      ];
      allowedUDPPortRanges = [
      ];
    };

    extraHosts = ''
      0.0.0.0 x.com
      0.0.0.0 twitter.com
            		'';

    #nameservers = [ "192.168.68.214" ];
    nameservers = [ "1.1.1.1" ];
  };
}
