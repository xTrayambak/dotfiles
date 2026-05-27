{
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    hostName = "lab";

    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        3000 # forgejo
      ];
      allowedUDPPorts = [
        3006 # luanti
      ];
      allowedTCPPortRanges = [ ];
      allowedUDPPortRanges = [ ];
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
