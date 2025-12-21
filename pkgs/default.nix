{ system, inputs, ... }:

{
	inherit system;

	config = {
		allowUnfree = true;
		permittedInsecurePackages = [
			"libsoup-2.74.3"
		];
	};

	overlays = (import ./overlays) ++ [
		inputs.nur.overlays.default
		inputs.templ.overlays.default
	];
}
