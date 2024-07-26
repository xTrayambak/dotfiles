{ pkgs, ... }:

{
	home.packages = with pkgs; [
		gcc
		libclang
		gdb
		just
		gnumake
		pkg-config
		valgrind
		lld
  	];
}
