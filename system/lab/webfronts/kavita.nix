{
  services.kavita = {
    enable = true;
    dataDir = "/pool/kavita";
    settings = {
      Port = 3012;
      IpAddresses = "0.0.0.0";
      BaseUrl = "/";
    };
    tokenKeyFile = "/tmp/kavita.txt";
  };

  systemd.tmpfiles.rules = [
    "d /pool/kavita 0750 kavita kavita - -"
    "Z /pool/kavita 0750 kavita kavita - -"
  ];
}
