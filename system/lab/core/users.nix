{ pkgs, ... }:
{
  users.users = {
    tray = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
      initialPassword = "deinemutteristlecker";
      shell = pkgs.bash;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZW9/8yqiusIbHXpntZigTstZY5d7G8FzqcH5HbzVjG xtrayambak@gmail.com"
      ];
    };

    arnav = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "meowmeowmrrp";
      shell = pkgs.bash;
    };

    open-webui = {
      isNormalUser = false;
      extraGroups = [ ];
      shell = "";
    };
  };
}
