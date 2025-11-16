{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ../../overlays/dwm-flexipatch)
  ];

  environment.systemPackages = with pkgs; [
    dwm-flexipatch
    j4-run
    acpi
  ];

  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm-flexipatch;
    };
  };
}
