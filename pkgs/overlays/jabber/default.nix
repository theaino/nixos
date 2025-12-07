final: prev: {
	lchat = prev.stdenv.mkDerivation {
    pname = "lchat";
    version = "1.0";

    src = prev.fetchgit {
			url = "https://git.suckless.org/lchat";
      rev = "58143731f1a6db77f271eed1cd4ada82538ad17b";
      sha256 = "sha256-s8URn2EeSAQwHtBQSR55ylPaKY3UrXXp4Ruoi+RYSrY=";
    };

    buildInputs = with prev; [
			libgrapheme
			coreutils
			gnugrep
    ];

    makeFlags = [
			"DESTDIR=$(out)"
			"MAN1DIR=/share/man/man1"
			"BINDIR=/bin"
      "CC=${prev.stdenv.cc.targetPrefix}cc"
    ];

		preBuild = ''
			${prev.coreutils}/bin/mkdir -p $out/bin
		'';

		preInstall = ''
			${prev.coreutils}/bin/mkdir -p $out/share/man/man1
		'';
  };

	sj = prev.stdenv.mkDerivation {
		pname = "sj";
		version = "0.1.0";

		src = prev.fetchFromGitHub {
			owner = "younix";
			repo = "sj";
			rev = "bbaadd2ef5de7dbe5d99802e39df2b82fedda815";
			hash = "sha256-tPU4RabB0Ybdkr3LVFUYeZ0w0ttWtvfSY1TrKO9kkVs=";
			fetchSubmodules = true;
		};

		nativeBuildInputs = with prev; [
			pkg-config
		];

		buildInputs = with prev; [
			minixml
			libbsd
			ucspi-tcp
		];

		makeFlags = [
			"HOME=$(out)"
      "CC=${prev.stdenv.cc.targetPrefix}cc"
		];
	};
}
