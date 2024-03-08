{ flake_path, ... }:
{
	imports = [
	  ./system/default.nix
	];
	networking.hostName = "box";
	services = {
		tlp.enable = true;
	};
}
