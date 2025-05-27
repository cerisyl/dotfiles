{ config, lib, myHostname, ... }:
if myHostname == "lux" then {
  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Nvidia power management
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module
    open = false;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`
    nvidiaSettings = true;

    # You may need to select the appropriate driver version for your specific GPU
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Prime (for offloading)
    prime = {
      offload.enable  = true;
      intelBusId      = "PCI:0:2:0";
      nvidiaBusId     = "PCI:1:0:0";
    }; 
  };
} else {}