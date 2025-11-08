{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.rclone ];

  home.activation.keepCloud = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ${config.home.homeDirectory}/cloud
  '';

  # Configure rclone (one-time setup)
  # Run: rclone config
  # Choose "webdav" as the type
  # Enter your Nextcloud URL and credentials
  # Password is stored encrypted in ~/.config/rclone/rclone.conf

  systemd.user.services.rclone-nextcloud = {
    Unit = {
      Description = "Rclone mount for Nextcloud";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone mount nextcloud: %h/cloud --vfs-cache-mode full --allow-non-empty";
      ExecStop = "/run/current-system/sw/bin/fusermount -u %h/cloud";
      Environment = "PATH=/run/wrappers/bin:$PATH";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
