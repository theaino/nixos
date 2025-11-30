{ config, pkgs, lib, ... }:

let
	cfg = config.mail;
in
{
	imports = [
		./neomutt.nix
		./thunderbird.nix
	];

	options.mail = {
		enable = lib.mkEnableOption "Enable mail client";
		variant = lib.mkOption {
			type = lib.types.enum [ "neomutt" "thunderbird" ];
			default = "neomutt";
			description = "The mail client variant to use";
		};
	};

	config = lib.mkIf cfg.enable (lib.mkMerge [
		{
			sops.secrets = {
				"mail-pass".sopsFile = ../../../../../secrets/mail.yaml;
			};

			accounts.email = {
				maildirBasePath = "Mail";
				accounts = {
					"info@aino-spring.com" = {
						primary = true;
						realName = "Aino Spring";
						address = "info@aino-spring.com";
						userName = "info@aino-spring.com";

						imap = {
							host = "imap.ionos.de";
							port = 993;
						};

						passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.mail-pass.path}";
					};
				};
			};
		}
	]);
}
