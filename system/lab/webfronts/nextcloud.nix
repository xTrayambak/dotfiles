{ config, pkgs, ... }:
{
  age.secrets.nextcloud = {
    file = ../../../secrets/nextcloud.age;
    owner = "nextcloud";
    group = "nextcloud";
    mode = "0400";
  };

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

    secretFile = config.age.secrets.nextcloud.path;

    settings = {
      default_phone_region = "IN";
      mail_domain = "xtrayambak.xyz";
      mail_smtpmode = "smtp";
      mail_smtphost = "smtp.resend.com";
      mail_smtpport = 465;
      mail_smtpsecure = "ssl";
      mail_smtpauth = true;
      mail_smtpname = "resend";
      mail_from_address = "no-reply";
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
      inherit (config.services.nextcloud.package.packages.apps) mail;
    };
  };

  systemd.tmpfiles.rules = [
    "d /pool/nextcloud 0750 nextcloud nextcloud - -"
    "Z /pool/nextcloud 0750 nextcloud nextcloud - -"
  ];
}
