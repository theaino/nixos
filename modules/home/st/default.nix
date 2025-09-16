{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (st.override {
      conf = builtins.readFile ./config.def.h;
      patches = [
        (pkgs.fetchpatch {
          url = "https://st.suckless.org/patches/anysize/st-expected-anysize-0.9.diff";
          hash = "sha256-YosSUn9eALdCt/EsNwNVyOkakJvNnTq251FBCpCb+xE=";
        })
      ];
    })
  ];
}
