{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    stateDir = "/pool/git";

    settings = {
      server = {
        DOMAIN = "git.xtrayambak.xyz";
        ROOT_URL = "https://git.xtrayambak.xyz";
        HTTP_PORT = 3000;
      };
      service = {
        DISABLE_REGISTRATION = true;
        REQUIRE_SIGNIN_VIEW = true;
        ENABLE_ROBOTS_TXT = true;
        ENABLE_CAPTCHA = true;
      };
      federation.ENABLED = true;
    };

    lfs.enable = true;

    # Keep backing up stuff to the backup drive because I'm not very fond of losing my stuff
    dump = {
      enable = true;
      type = "zip";
      backupDir = "/backup/git";
      age = "8w";
    };
  };
}
