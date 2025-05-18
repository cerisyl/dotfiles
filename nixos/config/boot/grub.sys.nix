{ config, pkgMap, theme, getThemeFile, myHostname, lib, ... }: let
  passthrough = if myHostname == lux
    then [ "intel_iommu=on" "immou=pt" ''vfio-pci.ids="10de:2482,10de:228b"'' ]
    else [];
  passthroughExtra = if myHostname == lux then {
    kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];
    blacklistedKernelModules = [ "nouveau" ];
    modprobeConfig = ''
      vfio-pci ids=10de:2482,10de:228b
      softdep nvidia pre: vfio-pci
    '';
  } else {
    kernelModules = [];
    blacklistedKernelModules = [];
    modprobeConfig = "";
  };
in {
  boot = {
    kernelParams = [
      "quiet" "splash" "boot.shell_on_fail" "loglevel=3"
      "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3"
    ] // passthrough;
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader = {
      #efi.canTouchEfiVariables = true;
      timeout = 0;
      grub = {
        enable          = true;
        devices         = [ "nodev" ];
        efiSupport      = true;
        useOSProber     = true;
        timeoutStyle    = "hidden";
        backgroundColor = "#1a1a1f";
        splashImage     = null;
        theme           = "/home/ceri/.nix/themes/ceres/grub";
        efiInstallAsRemovable = true;
      };
    };
  } // passthroughExtra;
}