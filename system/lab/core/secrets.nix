let
  trayKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZW9/8yqiusIbHXpntZigTstZY5d7G8FzqcH5HbzVjG xtrayambak@gmail.com";
  serverKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICREqkEJrvdDzjpRZBmbMXavnoQvGdr+/etyF6GuiYGc root@lab";
in
{
  "playit-secret.age".publicKeys = [
    trayKey
    serverKey
  ];
}
