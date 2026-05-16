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
      rpc_bind_addr = "[::]:3901";

      s3_api = {
        api_bind_addr = "[::]:3900";
        s3_region = "hell";
        root_domain = ".s3.xtrayambak.xyz";
      };

      s3_web = {
      };
    };
  };
}
