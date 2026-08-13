{ inputs, pkgs, ... }:
let
  gameVersion = "26.1.2";
in
{
  environment.systemPackages = with pkgs; [
    mcrcon
    tmux
  ];

  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.gooncraft = {
      enable = true;
      openFirewall = true;
      autoStart = true;
      serverProperties = {
        server-port = 25565;
        difficulty = 3;
        gamemode = 0;
        max-players = 20;
        motd = "GoodnightCraft Season 2";
        white-list = true;
        enable-rcon = true;
        online-mode = false;
        "rcon.password" = "password";
      };
      whitelist = {
        xTrayambak = "98d0333e-f17a-4721-babf-cf89ae416b33";
      };
      operators = {
        xTrayambak = {
          uuid = "98d0333e-f17a-4721-babf-cf89ae416b33";
          level = 3;
          bypassesPlayerLimit = true;
        };
      };
      package = pkgs.fabricServers.fabric-26_1_2.override { loaderVersion = "0.19.2"; };

      symlinks = {
        # mods ban this guy
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/BLz7ETCw/fabric-api-0.149.1%2B26.1.2.jar?mr_download_reason=standalone&mr_game_version=${gameVersion}";
              sha256 = "";
            };
            Bluemap = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/swbUV1cr/versions/D9j76thC/bluemap-5.20-fabric.jar?mr_download_reason=standalone&mr_game_version=${gameVersion}&mr_loader=fabric";
              sha256 = "sha256-ZO1PAAmfRtN21vL/Vq1thOtCie2Gxir+f84t/TW+siY=";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/Oqq8TOAV/lithium-fabric-0.24.7%2Bmc26.1.2.jar?mr_download_reason=standalone&mr_game_version=${gameVersion}&mr_loader=fabric";
              sha256 = "";
            };
            Chunky = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fALzjamp/versions/4Eotm6ov/Chunky-Fabric-1.5.3.jar?mr_download_reason=standalone&mr_game_version=${gameVersion}&mr_loader=fabric";
              sha256 = "sha256-7N/FWg9n8+xvQIUGh2FclBriJr2I9OBhiKeyaP09qUI=";
            };
            C2me = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/wGnmDPvI/c2me-fabric-mc26.1.1-0.3.7%2Balpha.0.63.jar?mr_download_reason=standalone&mr_game_version=${gameVersion}&mr_loader=fabric";
              sha256 = "";
            };
          }
        );
      };
    };
  };
}
