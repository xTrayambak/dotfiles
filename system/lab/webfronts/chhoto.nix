{ ... }:
{
  services.chhoto-url = {
    enable = true;
    settings = {
      port = 3003;
      hash_algorithm = "Argon2";
      slug_style = "UID";
      slug_length = 16;
      try_longer_slugs = true;
      public_mode = false;
      disable_frontend = false;
      db_url = "/pool/chhoto/urls.sqlite";
      site_url = "links.xtrayambak.xyz";
    };
  };

  systemd = {
    services.chhoto-url.serviceConfig.User = "chhoto-url";
    tmpfiles.rules = [
      "d /pool/chhoto 0750 chhoto-url chhoto-url - -"
      "Z /pool/nextcloud 0750 chhoto-url chhoto-url - -"
    ];
  };
}
