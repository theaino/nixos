{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
      ${coreutils}/bin/mkdir -p $out/share/applications
      ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in [
    libnotify
    pavucontrol
    steam
    (GPUOffloadApp steam "steam")
    bitwarden-desktop
    bitwarden-cli
    orca-slicer
    thunderbird
    libreoffice-still
    godot-mono
    gimp3-with-plugins
    blender
    legcord
    sfxr
    spotify
    freecad
    kicad
    librecad
    openscad
    prismlauncher
    gamescope
    nextcloud-client
    inkscape
    paperkey

    signal-desktop
    gajim
    profanity
  ];

  services.dunst.enable = true;
  xdg.configFile."dunst/dunstrc".text = '''';
}
