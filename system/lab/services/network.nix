{
  networking = {
    networkmanager.enable = true;
    hostName = "lab";

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
    };
  };
}
