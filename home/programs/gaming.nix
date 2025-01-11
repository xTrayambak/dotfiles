{ pkgs, ... }:

{
	home.packages = [
		pkgs.prismlauncher
		pkgs.mangohud
		pkgs.xonotic
		pkgs.steam
		pkgs.wine-staging
		pkgs.bottles
		pkgs.wl-clipboard
	];

	# radioactive shit. whoever wrote this deserves to stub their toe on a lego because it's intentionally bad.
	#services.flatpak = {
	#	enable = true;
	#	packages = [
	#		{ appId = "https://sober.vinegarhq.org/sober.flatpakref"; origin = ""; }
	#		{ appId = "org.gimp.GIMP"; origin = "flathub"; }
	#	];
	#};

	# programs.java = {
	#	enable = true;
	#	package = pkgs.jdk21;
	#};
}
