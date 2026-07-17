{ inputs, pkgs, ... }: {
  home.packages = [ inputs.agenix.packages.${pkgs.system}.default ];
}
