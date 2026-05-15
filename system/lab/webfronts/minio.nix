{ ... }:
{
  services.minio = {
    enable = true;
    listenAddress = ":9000";
    dataDir = [
      "/pool/minio"
      "/backup/minio"
    ];
    browser = true;
    region = "ap-south-1";
    rootCredentialsFile = "/home/tray/.minio";
  };
}
