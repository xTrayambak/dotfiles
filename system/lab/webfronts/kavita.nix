{
  services.kavita = {
    enable = true;
    dataDir = "/pool/kavita";
    settings = {
      TokenKey = "SdJ6avwSovPnI3pjl636uB7sx1Odwe0W1dMhP29vnighK1R2CcQFxNgjnI8jQxpqdrx72PiOkjO/OyDruAtNKw==";
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
