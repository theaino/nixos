{ config, pkgs, lib, ... }:

let
	cfg = config.wallpaper;

	themeWallpaper = pkgs.runCommand "themed-wallpaper" {} ''
		${pkgs.coreutils}/bin/mkdir -p $out

		${pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
			image-go-nord
		])}/bin/python3 << EOF
from ImageGoNord import GoNord
from os import environ
from os.path import join

go_nord = GoNord()
image = go_nord.open_image("${cfg.path}")

go_nord.reset_palette()

go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base00}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base01}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base02}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base03}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base04}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base05}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base06}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base07}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base08}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base09}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base0A}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base0B}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base0C}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base0D}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base0E}")
go_nord.add_color_to_palette("${config.lib.stylix.colors.withHashtag.base0F}")

go_nord.convert_image(image, save_path=join(environ["out"], "img.png"))
EOF
	'';
in
{
	options.wallpaper = {
		enable = lib.mkEnableOption "Enable the wallpaper";
		path = lib.mkOption {
			type = lib.types.path;
			description = "The path to the wallpaper image file";
		};
		theme = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "Adjust the image to the stylix theme";
		};
	};

	config = lib.mkIf cfg.enable {
		home.file.".background-image/wallpaper.png".source = "${themeWallpaper}/img.png";
	};
}
