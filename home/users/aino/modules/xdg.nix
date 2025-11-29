{ config, lib, ... }:

{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = lib.mkMerge [
				(lib.mkIf config.browser.enable {
					"x-scheme-handler/http" = [ "${config.browser.variant}.desktop" ];
					"x-scheme-handler/https" = [ "${config.browser.variant}.desktop" ];
					"x-scheme-handler/about" = [ "${config.browser.variant}.desktop" ];
					"x-scheme-handler/unknown" = [ "${config.browser.variant}.desktop" ];
					"text/html" = [ "${config.browser.variant}.desktop" ];
				})
				{
					"application/pdf" = [ "zathura.desktop" ];
				}
			];
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
