{ system, ... }:

{
	inherit system;

	config.allowUnfree = true;

	overlays = [
		(import ./dwm-flexipatch)
	];
}
