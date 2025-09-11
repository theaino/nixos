{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
  ];

  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.override {
        conf = ./config.def.h;
        patches = [
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/noborder/dwm-noborderfloatingfix-6.2.diff";
            hash = "sha256-osxrOsizPhOpQ1a+tDPMbmKsjvA+FMC8ZwbfiINnnYQ=";
          })
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/cool_autostart/dwm-cool_autostart-6.5.diff";
            hash = "sha256-AQToo5L7GkUnOTlKlpWt55g24MGgXuxlV37VAJElycc=";
          })
        ];
      };
    };
  };
}
