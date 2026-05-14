{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = false;
    };
    openFirewall = true;
  };
}
