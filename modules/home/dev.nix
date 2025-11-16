{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnumake
    git
    glib
    gsettings-desktop-schemas
    gh
    gcc15
    python3
    go
    cargo
    rustc
    zbar
    qrencode
    dmtx-utils
    usbutils
    libusb1
    arduino-ide
    protobuf
    sqlitebrowser
    inetutils
  ];
   
  programs.git = {
    enable = true;
    settings = {
      user = {
	name = "Aino Spring";
	email = "info@aino-spring.com";
      };
      credential.helper = "store";
      "credential \"https://github.com\"" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
      "credential \"https://gist.github.com\"" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      vig = "nvim --listen /tmp/godothost";
    };
    bashrcExtra = ''
      export PATH="$HOME/go/bin:$PATH"
    '';
  };
}
