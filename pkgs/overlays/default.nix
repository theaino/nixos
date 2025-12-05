[
	(import ./dwm-flexipatch)

	(final: prev: {
		poezio = prev.poezio.overrideAttrs (old: {
			version = "git";

			src = prev.fetchFromGitea {
				domain = "codeberg.org";
				owner = "poezio";
				repo = "poezio";
				rev = "b7f79dac0c9af529ee20289f30bb39b6099370a6";
				hash = "sha256-o2L0jz3lPJmHrudAHXz335KceGSziW9lxAD/AZ44Zas=";
			};

			nativeBuildInputs = with prev; (old.nativeBuildInputs or [ ]) ++ [
				sphinx
			];
			build-system = with prev.python3.pkgs; (old.build-system or [ ]) ++ [
				sphinx
			];
		});
	})
]
