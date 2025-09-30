{ config, pkgs, lib, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.printing = {
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = with pkgs; [ gutenprint cups-filters cups-browsed brlaser cups-brother-hll2350dw ];
  };
}
