{ pkgs, ... }:

{
	home.packages = with pkgs; [
		clang
		libclang
  	];
}
