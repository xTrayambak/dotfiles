{ pkgs, ... }: {
  services.qbittorrent = {
    enable = true;
    openFirewall = false;
    serverConfig = {
      LegalNotice.Accepted = true;
      Preferences = {
        WebUI = {
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
        Session.DefaultSavePath = "/pool/torrents";
        General.Locale = "en";
      };
    };
    webuiPort = 3011;
  };
}
