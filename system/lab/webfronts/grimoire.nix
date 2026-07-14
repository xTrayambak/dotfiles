{ pkgs, ... }:
let
  port = "6767";
  rebuildScript = pkgs.writeShellScriptBin "grimoirevoncrimson" ''
    cd /home/nginx/grimoire
    ${pkgs.git}/bin/git pull origin master
    ${pkgs.nim}/bin/nimble build -d:release --opt:speed
    PORT=${port} ./grimoire
  '';
in
{
  systemd.services.grimoiresite = {
    enable = true;
    description = "Sherlocked thingmajig";
    serviceConfig = {
      Type = "oneshot";
      User = "nginx";
      ExecStart = "${rebuildScript}/bin/grimoirevoncrimson";
    };
  };
}
