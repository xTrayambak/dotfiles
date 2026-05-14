{ pkgs, ... }:
{
  users.users.tray = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    initialPassword = "deinemutteristlecker";
    shell = pkgs.bash;
  };

  environment.variables = {
    EDITOR = "vim";
  };
}
