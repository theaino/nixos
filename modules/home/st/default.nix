{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (st.override {
      conf = builtins.readFile ./config.def.h;
    })
  ];
}
