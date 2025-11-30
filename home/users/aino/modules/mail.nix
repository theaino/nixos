{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
		thunderbird
  ];

	sops.secrets = {
		"mail-pass".sopsFile = ../../../../secrets/mail.yaml;
	};

	# Inspiration: https://github.com/Baitinq/nixos-config/blob/c9851e910f6e0dc574527e2da4be29d704eda27d/modules/email/default.nix
	accounts.email.maildirBasePath = "Mail";
	accounts.email.accounts = {
		"info@aino-spring.com" = {
			primary = true;
			realName = "Aino Spring";
			address = "info@aino-spring.com";
			userName = "info@aino-spring.com";

			imap = {
				host = "imap.ionos.de";
				port = 993;
			};

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

			passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.mail-pass.path}";

			neomutt = {
				enable = true;
				mailboxName = "Inbox";
			};
		};
	};

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
			{ map = [ "index" ]; key = "$"; action = "<shell-escape>mbsync --all<Enter>"; }
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
}
