{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
  ];

  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = (pkgs.dwm.overrideAttrs (old: {
        name = "dwm6.3";
        src = pkgs.fetchgit {
          url = "https://git.suckless.org/dwm";
          rev = "d39e2f3441fe18aba8d1a62c08918a411ec6f237";
          # nix-shell -p nix-prefetch-git --run "nix-prefetch-git https://git.suckless.org/dwm --rev COMMIT_HASH"
          hash = "sha256-pd1yi+DQ7xEV0iDyX+jC4KtcsfnqTH5ZOmPw++gSt8E=";
        };
      })).override {
        conf = ./config.def.h;
        # `nix-prefetch-url "https://dwm.suckless.org/patches/path/to/patch.diff" | xargs nix hash to-sri --type sha256`
        patches = [
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/bakkeby/patches/refs/heads/master/dwm/dwm-alpha-systray-6.3_full.diff";
            hash = "sha256-qo0zBu1UIyGKpjR4Ya2yrkdXIIy6ShRv5BFR7yqngYk=";
          })
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/noborder/dwm-noborderfloatingfix-6.2.diff";
            hash = "sha256-osxrOsizPhOpQ1a+tDPMbmKsjvA+FMC8ZwbfiINnnYQ=";
          })
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/cool_autostart/dwm-cool-autostart-6.2.diff";
            hash = "sha256-8Mts7fJnR+OS1jY84AvJIUQp9pa/LVff0WMOYVVw2gs=";
          })
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/bakkeby/patches/refs/heads/master/dwm/dwm-vanitygaps-6.3.diff";
            hash = "sha256-50vba9YNW5E25IVSf4734KQRb56fK9KjSSajgPNOV/E=";
          })
        ];
      };
    };
  };
}
