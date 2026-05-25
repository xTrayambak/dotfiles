{ pkgs, ... }:
let
  gameId = "voxelibre";
  worldName = "goodnightcraft";

  voxelibreSrc = pkgs.fetchFromGitHub {
    owner = "VoxeLibre";
    repo = "VoxeLibre";
    rev = "0.91.2";
    hash = "";
  };
in
{
  environment.systemPackages = with pkgs; [
    luanti-server
  ];

  users.users.gncraft = {
    isNormalUser = true;
    extraGroups = [ ];
    initialPassword = "minetest";
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [ ];
  };

  systemd.services = {
    gncraft = {
      description = "GoodnightCraft Season 2";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        mkdir -p ~/.minetest/worlds/
        mkdir -p ~/.minetest/games/

        if [ ! -d ".minetest/games/${gameId}" ]; then
          ln -sfn ${voxelibreSrc} ".minetest/games/${gameId}"
        fi
      '';

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.luanti-server}/bin/luantiserver --gameid ${gameId} --worldname ${worldName} --terminal";
        User = "gncraft";

        /*
          Restart = "on-failure";
          	RestartSec = "2s";
        */
      };
    };
  };
}
