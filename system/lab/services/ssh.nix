{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      Banner = ''
        Welcome to my cute server :D
        Please don't try mining crypto here, it's barely 2 cores and you won't get anything besides
        making my bedroom hotter and my electricity bills more expensive! :(

        Anyways, enjoy your stay. :3
      '';
    };
    openFirewall = true;
  };
}
