{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnumake
    git
    gh
    gcc15
    python3
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

  home.shellAliases = {
    vig = "nvim --listen /tmp/godothost";
  };
}
