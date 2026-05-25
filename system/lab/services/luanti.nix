{ pkgs, ... }:
let
  gameId = "voxelibre";
  worldName = "goodnightcraft";
  user = "gncraft";

  voxelibreSrc = pkgs.fetchFromGitHub {
    owner = "VoxeLibre";
    repo = "VoxeLibre";
    rev = "0.91.2";
    hash = "sha256-dHpuwvcTc2+O0PJqhxNvNYmHkvt3K+hlhbGJN3a+PEM=";
  };
in
{
  environment.systemPackages = with pkgs; [
    luanti-server
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ ];
    initialPassword = "minetest";
    createHome = true;
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [ ];
  };

  systemd.services = {
    gncraft = {
      description = "GoodnightCraft Season 2";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        mkdir -p /home/${user}/.minetest/worlds/
        mkdir -p /home/${user}/.minetest/games/

        if [ ! -d "/home/${user}/.minetest/games/${gameId}" ]; then
          ln -sfn ${voxelibreSrc} "/home/${user}/.minetest/games/${gameId}"
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
