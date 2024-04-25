{ inputs, lib, pkgs, ... }:

{
	home.packages = with pkgs; [
		clang
		libclang
  	];
}
