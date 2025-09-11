{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
  };

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "aino";
  };


  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "escape";
  	  escape = "capslock";
          };
          otherlayer = {};
        };
      };
    };
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
