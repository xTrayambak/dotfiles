{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    stateDir = "/pool/git";

    settings = {
      server = {
        DOMAIN = "lab.local";
        HTTP_PORT = 3000;
      };
    };

    # Keep backing up stuff to the backup drive because I'm not very fond of losing my stuff
    dump = {
      enable = true;
      type = "zip";
      backupDir = "/backup/git";
      age = "8w";
    };
  };
}
