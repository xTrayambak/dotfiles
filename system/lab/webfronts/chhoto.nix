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
      # FIXME: For some reason, it just refuses to use the HDD.
      # db_url = "/pool/chhoto/urls.sqlite";
      site_url = "links.xtrayambak.xyz";
    };
  };

  systemd = {
    services.chhoto-url.serviceConfig.User = "chhoto-url";
  };
}
