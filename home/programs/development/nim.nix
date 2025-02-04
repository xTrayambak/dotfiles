{ pkgs, ... }:

{
	home.packages = with pkgs; [
		nim-unwrapped-2
		nph
		nimlsp
		valgrind
		nimble
  	];
}
