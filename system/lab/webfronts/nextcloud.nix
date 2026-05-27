{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    home = "/pool/nextcloud";
    hostName = "nc.xtrayambak.xyz";
    https = true;
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

    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) memories;
    };
  };

  systemd.tmpfiles.rules = [
    "d /pool/nextcloud 0750 nextcloud nextcloud - -"
    "Z /pool/nextcloud 0750 nextcloud nextcloud - -"
  ];
}
