{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
