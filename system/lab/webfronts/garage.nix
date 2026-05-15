{ ... }:
{
  services.garage = {
    enable = true;
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
