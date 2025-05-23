{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  services.samba = {
    enable        = true;
    securityType  = "user";
    settings.global   = {
      "hosts allow" = "192.168.122.0/24 192.168.123.0/24 127.0";
      "interfaces"  = "lo virbr0";
      "bind interfaces only" = "yes";
    };
    shares = {
      share = {
        path              = "/home/ceri";
        browseable        = "yes";
        writeable         = "yes";
        "guest ok"        = "no";
        "valid users"     = "ceri";
        "create mask"     = "0644";
        "directory mask"  = "0755";
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 139 445 ];
    allowedUDPPorts = [ 137 138 ];
  };
} else {}