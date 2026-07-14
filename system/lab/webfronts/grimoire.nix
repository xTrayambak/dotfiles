{ pkgs, ... }:
let
  port = "6767";
  rebuildScript = pkgs.writeShellScriptBin "grimoirevoncrimson" ''
    export HOME=/home/nginx
    cd /home/nginx/grimoire

    # ${pkgs.git}/bin/git pull origin master
    ${pkgs.nimble}/bin/nimble build -d:release --opt:speed
    PORT=${port} ./grimoire
  '';
in
{
  systemd.services.grimoiresite = {
    enable = true;
    description = "Sherlocked thingmajig";
    serviceConfig = {
      Type = "simple";
      User = "nginx";
      Restart = "on-failure";
      WorkingDirectory = "/home/nginx/grimoire";
      ExecStart = "${rebuildScript}/bin/grimoirevoncrimson";
    };
  };
}
