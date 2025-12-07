final: prev: {
	st-flexipatch = prev.stdenv.mkDerivation {
		pname = "st-flexipatch";
		version = "0.9.3";

		outputs = [
			"out"
			"terminfo"
		];

		src = prev.fetchFromGitHub {
			owner = "bakkeby";
			repo = "st-flexipatch";
			rev = "37bc089f1d9f3c53ded68d442dac3108b3366426";
			hash = "sha256-kLWuxgCKEGZJ0z78SGhfoP7QXO1Z+gASAysfRVYLGgw=";
		};

    nativeBuildInputs = with prev; [
      pkg-config
			ncurses
    ];

		buildInputs = with prev; [
			xorg.libX11
			xorg.libXft
			imlib2
		];

    prePatch = ''
      cp ${./patches.h} patches.h
      cp ${./config.h} config.h
      cp ${./config.mk} config.mk
    '';

    makeFlags = [
      "PREFIX=$(out)"
			"MANPREFIX=$(out)/share/man"
      "CC=${prev.stdenv.cc.targetPrefix}cc"
    ];

		preInstall = ''
			export TERMINFO=$terminfo/share/terminfo
			mkdir -p $TERMINFO $out/nix-support
			echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
		'';
	};
}
