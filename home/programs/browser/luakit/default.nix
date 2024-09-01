{ pkgs, ... }: {
	home.packages = [ pkgs.luakit ];
	xdg.configFile = {
		"luakit/userconf.lua".source = ./userconf.lua;
	};

	#home.file = {
	#	"/home/${config.home.username}/.local/share/luakit/adblock/easylist.txt".source = ./easylist.txt;
	#};
}
