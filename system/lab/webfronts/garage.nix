{ pkgs, ... }:
{
  services.garage = {
    enable = true;
    package = pkgs.garage;
    settings = {
      data_dir = [
        {
          path = "/pool/garage/data";
          read_only = false;
          capacity = "1T";
        }
      ];
      metadata_dir = "/pool/garage/meta";
    };
  };
}
