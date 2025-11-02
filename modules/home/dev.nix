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
    usbutils
    libusb1
    arduino-ide
    protobuf
    sqlitebrowser
  ];
   
  programs.git = {
    enable = true;
    userName = "Aino Spring";
    userEmail = "info@aino-spring.com";
    extraConfig = {
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
