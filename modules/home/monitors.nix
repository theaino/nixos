{ config, pkgs, lib, ... }:

{
  services.grobi = {
    enable = true;
    rules = [
      {
        name = "Home";
        outputs_connected = [ "eDP-1" "HDMI-1" ];
        primary = "HDMI-1";
        configure_row = [ "HDMI-1" "eDP-1" ];
        atomic = true;
      }
    ];
  };
}
