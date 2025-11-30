{ config, pkgs, lib, ... }:

let
	cfg = config.mail;
in
{
	config = lib.mkIf (cfg.enable && cfg.variant == "neomutt") {
		programs.mbsync.enable = true;
		programs.msmtp.enable = true;
		programs.neomutt = {
			enable = true;
			sidebar.enable = true;
			vimKeys = true;
			sort = "reverse-date";
			extraConfig = ''
				set mailcap_path = ${config.home.homeDirectory}/.config/neomutt/mailcap
				auto_view text/html
				set wait_key = no
			'';
			macros = [
				{ map = [ "pager" ]; key = "\\cb"; action = "<pipe-message> ${pkgs.urlscan}/bin/urlscan<Enter>"; }
				{ map = [ "pager" ]; key = "\\ce"; action = "<pipe-message> $EDITOR<Enter>"; }
				{ map = [ "index" ]; key = "$"; action = "<shell-escape>${pkgs.isync}/bin/mbsync --all<Enter>"; }
			];
		};

		services.mbsync.enable = true;
		services.imapnotify.enable = true;

		xdg.configFile."neomutt/mailcap".text = ''
text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
image/*; ${pkgs.feh}/bin/feh '%s';
application/pdf; ${pkgs.zathura}/bin/zathura '%s';
application/x-pdf; ${pkgs.zathura}/bin/zathura '%s';
		'';

		accounts.email.accounts."info@aino-spring.com" = {
			smtp = {
				host = "smtp.ionos.de";
				port = 465;
			};

			imapnotify = {
				enable = true;
				boxes = [ "Inbox" ];
				onNotifyPost = ''
					${pkgs.libnotify}/bin/notify-send "New mail arrived"
				'';
			};
			msmtp.enable = true;
			mbsync = {
				enable = true;
				create = "both";
			};

			neomutt = {
				enable = true;
				mailboxName = "Inbox";
			};
		};
	};
}
