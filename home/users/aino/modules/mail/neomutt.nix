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

				color normal        color7				color0
				color indicator     color0				color4
				color tree          default      	default
				color status        color15       color8
				color error         color1        color0
				color message       color4        color0
				color signature     color14       color0
				color attachment    italic color3 color0
				color search        color15       color3
				color tilde         default       default
				color markers       default       default
				color hdrdefault    color14       color0
			'';
			macros = [
				{ map = [ "pager" ]; key = "\\cb"; action = "<pipe-message> ${pkgs.urlscan}/bin/urlscan<Enter>"; }
				{ map = [ "pager" ]; key = "\\ce"; action = "<pipe-message> $EDITOR<Enter>"; }
				{ map = [ "index" ]; key = "$"; action = "<shell-escape>${pkgs.isync}/bin/mbsync --all<Enter>"; }
			];
			binds = [
				{ map = [ "index" "pager" ]; key = "\\cn"; action = "sidebar-next"; }
				{ map = [ "index" "pager" ]; key = "\\cp"; action = "sidebar-prev"; }
				{ map = [ "index" "pager" ]; key = "\\co"; action = "sidebar-open"; }
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
				extraMailboxes = [ "Sent" ];
			};
		};
	};
}
