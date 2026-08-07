{
  services.suwayomi-server = {
    enable = true;
    dataDir = "/pool/suwayomi";
    user = "suwayomi";

    settings = {
      server = {
        ip = "0.0.0.0";
        port = 3012;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /pool/suwayomi 0750 suwayomi suwayomi - -"
    "Z /pool/suwayomi 0750 suwayomi suwayomi - -"
  ];
}
