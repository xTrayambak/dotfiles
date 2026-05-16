{ ... }:
{
  services.nextcloud = {
    enable = true;
    home = "/pool/nextcloud";
    hostName = "nc.xtrayambak.xyz";
    https = false;
    maxUploadSize = "100G";
    configureRedis = true;
    /*
      poolSettings = {
        pm = "dynamic";
        "pm.max_children" = "120";
        "pm.max_requests" = "500";
        "pm.max_spare_servers" = "18";
        "pm.min_spare_servers" = "6";
        "pm.start_servers" = "12";
        "pm.status_path" = "/status";
      };
    */

    database = {
      createLocally = true;
    };

    config = {
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = "/home/tray/.config/nextcloud/admin-password";
    };

    settings = {
      default_phone_region = "IN";
    };

    caching = {
      redis = true;
    };

    phpOptions = {
      "opcache.interned_strings_buffer" = "16";
    };
  };

  systemd.tmpfiles.rules = [
    "d /pool/nextcloud 0750 nextcloud nextcloud - -"
    "Z /pool/nextcloud 0750 nextcloud nextcloud - -"
  ];
}
