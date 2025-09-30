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
        (pkgs.fetchpatch {
          url = "https://st.suckless.org/patches/scrollback/st-scrollback-ringbuffer-0.9.2.diff";
          hash = "sha256-lhGYvhLgHiDqk82CLtc6kQalOGODlUYTqWquEivBQ+Q=";
        })
        (pkgs.fetchpatch {
          url = "https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
          hash = "sha256-QuSAPOKmeDX35TOnB6iijjgEomztFjFFEIlwua7l+4E=";
        })
      ];
    })
  ];
}
