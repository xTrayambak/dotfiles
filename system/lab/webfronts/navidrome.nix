{ pkgs, ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      Port = 3007;
      Address = "localhost";

      MusicFolder = "/pool/navidrome";
      CacheFolder = "/pool/navidrome/cache";

      Agents = "apple-music,deezer,lastfm,listenbrainz";

      EnableInsightsCollector = true; # help your local OSS project! ;)
    };
    plugins = with pkgs.navidromePlugins; [
      apple-music
    ];
  };
}
