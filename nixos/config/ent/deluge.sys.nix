{ config, pkgs, lib, myHostname, ... }:
if (myHostname != "engrit") then {
  services.deluge = {
    enable        = true;
    declarative   = true;
    package       = pkgs.deluge-gtk;
    openFirewall  = true;
    authFile      = pkgs.writeText "" ''localclient:notsecure:10'';
    config = {
      "dht"                       = false;
      "download_location"         = "/home/ceri/deluge";
      "listen_ports"              = [ 6881 6891 ];
      "listen_random_port"        = 62503;
      "max_active_downloading"    = 100;
      "max_active_limit"          = 100;
      "max_active_seeding"        = 100;
      "max_half_open_connections" = 50;
      "utpex"                     = false;
    };
  };
} else {}