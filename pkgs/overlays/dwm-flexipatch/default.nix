final: prev: {
  j4-run = (prev.writeShellScriptBin "j4_run" "${builtins.readFile ./j4_run.sh}");

  dwm-flexipatch = prev.stdenv.mkDerivation rec {
    pname = "dwm-flexipatch";
    version = "6.6";

    src = prev.fetchFromGitHub {
      owner = "bakkeby";
      repo = "dwm-flexipatch";
      rev = "a74df8bbcedd9f91841653844c71424d3ab4a0dc";
      sha256 = "sha256-csMXMCBuVGwO+1TG/MXm3yHyDNNjfpgAmbhT7a0mcrc=";
    };

    buildInputs = with prev; [
      xorg.libX11
      xorg.libXft
      xorg.libXinerama
      imlib2
    ];

    nativeBuildInputs = with prev; [
      pkg-config
    ];

    prePatch = ''
      ${prev.coreutils}/bin/cp ${./patches.h} patches.h
      ${prev.coreutils}/bin/cp ${./config.h} config.h
      ${prev.coreutils}/bin/cp ${./config.mk} config.mk
    '';

    makeFlags = [
      "PREFIX=$(out)"
      "CC=${prev.stdenv.cc.targetPrefix}cc"
    ];

    postInstall = ''
      ${prev.coreutils}/bin/mkdir -p $out/share/man/man1
      ${prev.coreutils}/bin/cp dwm.1 $out/share/man/man1/
    '';

    meta = with prev.lib; {
      description = "Dynamic window manager for X - flexipatch version";
      homepage = "https://github.com/bakkeby/dwm-flexipatch";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  };
}
