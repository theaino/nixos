{ config, lib, ... }:

let
	cfg = config.editor;
in
{
	imports = [
		./nvim.nix
	];

	options.editor = {
		enable = lib.mkEnableOption "Enable editor";
		variant = lib.mkOption {
			type = lib.types.enum [ "nvim" ];
			default = "nvim";
			description = "The editor variant to use";
		};
	};

	config = lib.mkIf cfg.enable (lib.mkMerge [
		(lib.mkIf (cfg.variant == "nvim") {
			programs.nixvim = {
				enable = true;
				defaultEditor = true;
			};
		})
	]);
}
