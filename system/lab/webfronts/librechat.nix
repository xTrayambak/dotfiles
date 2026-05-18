{ ... }:
{
  services.librechat = {
    enable = true;
    env = {
      PORT = 3006;
    };
    # meilisearch.enable = true;
    dataDir = "/pool/librechat";
    user = "librechat";
    group = "librechat";
    enableLocalDB = true;
  };

  systemd.tmpfiles.rules = [
    "d /pool/librechat 0750 librechat librechat - -"
    "Z /pool/librechat 0750 librechat librechat - -"
  ];
}
