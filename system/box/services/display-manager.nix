{
  services.xserver.enable = false;
  services.displayManager = {
    enable = false;
    /*
      gdm = {
        enable = true;
        wayland = true;
      };
    */
  };
}
