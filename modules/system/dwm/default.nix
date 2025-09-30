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
            # `nix-prefetch-url "https://dwm.suckless.org/patches/path/to/patch.diff" | xargs nix hash to-sri --type sha256`
            hash = "sha256-osxrOsizPhOpQ1a+tDPMbmKsjvA+FMC8ZwbfiINnnYQ=";
          })
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/cool_autostart/dwm-cool_autostart-6.5.diff";
            hash = "sha256-AQToo5L7GkUnOTlKlpWt55g24MGgXuxlV37VAJElycc=";
          })
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/alpha/dwm-alpha-20201019-61bb8b2.diff";
            hash = "sha256-Ig1DZpziTgN/jP5wCIk/oFp9posAZnvGXlWLdaBs1WM=";
          })
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/tilegap/dwm-tilegap-6.4.diff";
            hash = "sha256-+i7LtaEwOjzxkxd+Xo4OSPEQAZkHG9tZHatnpgqjo34=";
          })
        ];
      };
    };
  };
}
