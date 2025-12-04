final: prev: {
  surf = prev.stdenv.mkDerivation rec {
    pname = "surf";
    version = "2.1";

    src = prev.fetchgit {
			url = "git://git.suckless.org/surf";
      rev = "48517e586cdc98bc1af7115674b554cc70c8bc2e";
      sha256 = "sha256-+qg1mF5X/hYxCy7N3CxIEM2yHi1jmUGiK/vaQBjKy1I=";
    };

		nativeBuildInputs = with prev; [
			pkg-config
			wrapGAppsHook3
		];

    buildInputs = with prev; [
			glib
			gcr
			glib-networking
			gsettings-desktop-schemas
			gtk2
			libsoup_3
			webkitgtk_4_1
		] ++ (with gst_all_1; [
			gstreamer
			gst-plugins-base
			gst-plugins-good
			gst-plugins-bad
    ]);

    prePatch = ''
      cp ${./config.h} config.h
    '';

    makeFlags = [
      "PREFIX=$(out)"
      "CC=${prev.stdenv.cc.targetPrefix}cc"
    ];

		preFixup =
			let
				depsPath = with prev; lib.makeBinPath [
					xorg.xprop
					dmenu
					findutils
					gnused
					coreutils
				];
			in
			''
				gappsWrapperArgs+=(
					--suffix PATH : ${depsPath}
				)
			'';


    meta = with prev.lib; {
      description = "Simple web browser based on WebKitGTK";
      homepage = "https://surf.suckless.org";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };
}
