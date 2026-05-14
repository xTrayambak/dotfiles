{
  networking = {
    networkmanager.enable = true;
    hostName = "lab";

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [ ];
      allowedTCPPortRanges = [
      ];
      allowedUDPPortRanges = [
      ];
    };

    extraHosts = "";

    #nameservers = [ "192.168.68.214" ];
    nameservers = [ "1.1.1.1" ];
  };
}
