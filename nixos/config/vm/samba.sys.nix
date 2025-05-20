{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  services.samba = {
    enable        = true;
    securityType  = "user";
    extraConfig   = ''
      hosts allow = 192.168.122.0/24 127.0.0.1
      interfaces = lo virbr0
      bind interfaces only = yes
    '';
    shares = {
      main = {
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