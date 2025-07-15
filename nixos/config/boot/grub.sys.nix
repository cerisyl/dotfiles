{ config, pkgsLegacy, theme, getThemeFile, myHostname, lib, ... }: let
  # ,10de:1381,10de:0fbc
  hostKernelParams = {
    lux     = [ "intel_iommu=on" "iommu.passthrough=1" "iommu=pt" "vfio-pci.ids=10de:2482,10de:228b,10de:1381,10de:0fbc" ];
    nova    = [];
    engrit  = [];
    astore  = [];
    vm      = [];
  };
  hostOptions = {
    lux = {
      kernelPackages        = pkgsLegacy.linuxPackages;
      initrd.kernelModules  = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];
      kernelModules         = [ "kvmfr" ];
      extraModulePackages   = with pkgsLegacy.linuxPackages; [ kvmfr ];
      extraModprobeConfig   = ''
        options vfio-pci ids=10de:2482,10de:228b,10de:1381,10de:0fbc
        softdep nvidia pre: vfio-pci
        softdep nvidia_modeset pre: vfio-pci
        options kvmfr static_size_mb=128
      '';
    };
    nova = {
      initrd.kernelModules  = [ "i915" ];
    };
    engrit = {
      extraModprobeConfig   = "options snd_hda_intel power_save=1";
    };
    medea   = {};
    astore  = {};
    vm      = {};
  };
in {
  boot = {
    kernelParams = [
      "quiet" "splash" "boot.shell_on_fail" "loglevel=3"
      "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3"
    ] ++ hostKernelParams."${myHostname}";
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
  } // hostOptions."${myHostname}";
}
