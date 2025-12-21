{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
      ${coreutils}/bin/mkdir -p $out/share/applications
      ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in [
    libnotify
    pavucontrol
    steam
    (GPUOffloadApp steam "steam")
    orca-slicer
    libreoffice-still
    godot-mono
    gimp3-with-plugins
    blender
    sfxr
    freecad
    kicad
    librecad
    openscad
    prismlauncher
    gamescope
    nextcloud-client
    inkscape
    paperkey
		monero-gui
		xmrig
		xmrig-cuda
		wineWowPackages.stable
		winetricks

		teamspeak6-client
    signal-desktop
    gajim
		sj
		lchat
		poezio
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
      };
    };
  };

	home.file.".local/share/OpenSCAD/libraries/BOSL2".source = pkgs.fetchFromGitHub {
		owner = "BelfrySCAD";
		repo = "BOSL2";
		rev = "266792b2a4bbf7514e73225dfadb92da95f2afe1";
		sha256 = "sha256-MzUKQ50prQ8dc+MXXety76jT5/44Bx5Zxm5te/nrINE=";
	};

	programs.spicetify =
		let
			spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
		in
		{
			enable = true;
			enabledExtensions = with spicePkgs.extensions; [
				keyboardShortcut
				adblock
			];
		};
}
