{
  services.xserver.enable = false;
  services.displayManager = {
    enable = true;
    gdm = {
      enable = true;
    };
  };
}
