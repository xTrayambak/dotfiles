{ ... }:
let
  secretsDir = "/home/tray/.librechat";
in
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

    env = {
      # i don't even care
      CREDS_IV = builtins.readFile "${secretsDir}/creds-iv";
      JWT_REFRESH_SECRET = builtins.readFile "${secretsDir}/jwt-refresh-secret";
      CREDS_KEY = builtins.readFile "${secretsDir}/creds-key";
      JWT_SECRET = builtins.readFile "${secretsDir}/jwt-secret";
    };
  };

  systemd.tmpfiles.rules = [
    "d /pool/librechat 0750 librechat librechat - -"
    "Z /pool/librechat 0750 librechat librechat - -"
  ];
}
