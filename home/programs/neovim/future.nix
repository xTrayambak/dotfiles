{ pkgs, lib, inputs, ... }:
{
	imports = with inputs; [
		nixvim.homeManagerModules.nixvim
	];

	programs.nixvim = {
		enable = true;
		clipboard.providers.wl-copy.enable = true;
		globals.mapleader = "*";

		options = {
			number = true;
			relativenumber = false;
			shiftwidth = 4;
		};
		colorschemes.nord = {
			enable = true;
		};

		plugins = {
			nix.enable = true;
			lsp-lines.enable = true;
			lspkind.enable = true;

			fugitive.enable = true;
		};
	};
}
