{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    gnome-themes-extra
  ];

  xresources.properties = with config.lib.stylix.colors.withHashtag; {
    "dwm.normbordercolor" = base00;
    "dwm.normbgcolor" = base00;
    "dwm.normfgcolor" = base0D;
    "dwm.normfloatcolor" = base02;
    "dwm.selbordercolor" = base03;
    "dwm.selbgcolor" = base03;
    "dwm.selfgcolor" = base05;
    "dwm.selfloatcolor" = base07;

    "dwm.titlenormbordercolor" = base00;
    "dwm.titlenormbgcolor" = base00;
    "dwm.titlenormfgcolor" = base0D;
    "dwm.titlenormfloatcolor" = base02;
    "dwm.titleselbordercolor" = base03;
    "dwm.titleselbgcolor" = base03;
    "dwm.titleselfgcolor" = base05;
    "dwm.titleselfloatcolor" = base07;

    "dwm.tagsnormbordercolor" = base00;
    "dwm.tagsnormbgcolor" = base00;
    "dwm.tagsnormfgcolor" = base0D;
    "dwm.tagsnormfloatcolor" = base02;
    "dwm.tagsselbordercolor" = base03;
    "dwm.tagsselbgcolor" = base03;
    "dwm.tagsselfgcolor" = base05;
    "dwm.tagsselfloatcolor" = base07;

    "dwm.hidnormbordercolor" = base00;
    "dwm.hidnormbgcolor" = base00;
    "dwm.hidnormfgcolor" = base0D;
    "dwm.hidnormfloatcolor" = base02;
    "dwm.hidselbordercolor" = base03;
    "dwm.hidselbgcolor" = base03;
    "dwm.hidselfgcolor" = base05;
    "dwm.hidselfloatcolor" = base07;

    "dwm.urgnormbordercolor" = base00;
    "dwm.urgnormbgcolor" = base00;
    "dwm.urgnormfgcolor" = base0D;
    "dwm.urgnormfloatcolor" = base02;
    "dwm.urgselbordercolor" = base03;
    "dwm.urgselbgcolor" = base03;
    "dwm.urgselfgcolor" = base05;
    "dwm.urgselfloatcolor" = base07;
  };
}
