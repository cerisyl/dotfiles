{
  disko.devices = {
    disk = {
      main = {
        device  = "/dev/nvme0n1";
        type    = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              type = "EF00";
              size = "1G";
              content = {
                type          = "filesystem";
                format        = "vfat";
                mountpoint    = "/boot";
                mountOptions  = [ "umask=0077" ];
              };
            };
            swap = {
              size = "4G";
              content = {
                type          = "swap";
                resumeDevice  = true;
              };
            };
            root = {
              size = "100%";
              content = {
                type          = "filesystem";
                format        = "ext4";
                mountpoint    = "/";
              };
            };
          };
        };
      };
    };
  };
}