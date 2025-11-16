{ inputs, ... }:

{
  stylix.targets.nixcord.enable = false;

  programs.nixcord = {
    enable = true;
    config = {
      frameless = true;
      themeLinks = [
        "https://raw.githubusercontent.com/orblazer/discord-nordic/master/nordic.vencord.css"
      ];
      plugins = {
        fakeNitro.enable = true;
      };
    };
  };
}
