{ inputs, lib, pkgs, ... }:

{
	home.packages = with pkgs; [
		nim-unwrapped-2
		nimlsp
		nimble
  	];
}
