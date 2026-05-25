{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.gooncraft = {
      enable = true;
      package = pkgs.fabricServers.fabric-26_1_2.override { loaderVersion = "0.19.2"; };

      symlinks = {
        # mods ban this guy
        mods = pkgs.linkFarmFromDrvs "mods" (
	  builtins.attrValues {
	    Fabric-API = pkgs.fetchurl {
	      url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/BLz7ETCw/fabric-api-0.149.1%2B26.1.2.jar?mr_download_reason=standalone&mr_game_version=26.1.2";
	      sha512 = "";
	    };
	    Bluemap = pkgs.fetchurl {
		url = "https://cdn.modrinth.com/data/swbUV1cr/versions/D9j76thC/bluemap-5.20-fabric.jar?mr_download_reason=standalone&mr_game_version=26.1.2&mr_loader=fabric";
		sha512 = "";
	    };
	  };
	);
      };
    };
  };
}
