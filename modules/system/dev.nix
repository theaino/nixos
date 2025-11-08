{ config, pkgs, lib, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        bind-address = "0.0.0.0";
      };
    };
  };

  virtualisation.docker.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0666"
  '';
}
