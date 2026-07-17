{ config, ... }: {
  age.secrets = {
    librechat = ../../../secrets/librechat.age;
    airouter = ../../../secrets/airouter.age;
  };

  services.librechat = {
    enable = true;
    enableLocalDB = true;
    meilisearch = {
      enable = true;
    };
    dataDir = "/pool/librechat";
    env.PORT = 3008;

    credentials = {
      CREDS_KEY = config.age.secrets.librechat-creds-key.path;
      AIROUTER_KEY = config.age.secrets.airouter-key.path;
    };

    settings = {
      cache = true;
    };
  };
}
