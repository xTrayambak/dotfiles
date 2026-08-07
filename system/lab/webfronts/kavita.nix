{
  services.kavita = {
    enable = true;
    dataDir = "/pool/kavita";
    settings = {
      TokenKey = "";
      Port = 3012;
      IpAddresses = "0.0.0.0";
      BaseUrl = "/";
    };
  };

  systemd.tmpfiles.rules = [
    "d /pool/kavita 0750 kavita kavita - -"
    "Z /pool/kavita 0750 kavita kavita - -"
  ];
}
