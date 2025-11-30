{ config, lib, ... }:

let
	cfg = config.mail;
in
{
	config = lib.mkIf (cfg.enable && cfg.variant == "thunderbird") {
		programs.thunderbird = {
			enable = true;
			profiles.default = {
				isDefault = true;
			};
		};

		accounts.email.accounts."info@aino-spring.com".thunderbird.enable = true;
	};
}
