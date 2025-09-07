{ pkgs, ... }:
{
  services.printing.enable = true;

  # Support for autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # For scanning
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ]; # I _unfortunately_ own a HP printer.
  };

  services.printing.drivers = with pkgs; [
    gutenprint
    hplip
    brlaser
  ];
}
