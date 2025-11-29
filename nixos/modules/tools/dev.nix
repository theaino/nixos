{ config, lib, pkgs, ... }:

let
	cfg = config.tools.dev;
in
{
	options.tools.dev = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = config.tools.enable;
			description = "Enable dev tools";
		};
	};

	config = lib.mkIf cfg.enable {
		services.mysql = {
			enable = true;
			package = pkgs.mariadb;
			settings = {
				mysqld = {
					bind-address = "0.0.0.0";
				};
			};
		};

		virtualisation.docker.enable = true;
	};
}
