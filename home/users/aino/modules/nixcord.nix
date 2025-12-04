{ inputs, ... }:

{
  programs.nixcord = {
    enable = true;
    config = {
      frameless = true;
      plugins = {
        fakeNitro.enable = true;
      };
    };
  };
}
