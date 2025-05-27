{ config, lib, pkgs, myHostname, ... }: let
  vmNetworkOptions = if myHostname == "engrit" then {
    useDHCP = false;
    bridges.br0.interfaces = [ "enp0s31f6" "enp0s13f0u3u4u4" ];
    interfaces = {
      br0.useDHCP             = true;
      enp0s31f6.useDHCP       = false;
      enp0s13f0u3u4u4.useDHCP = false;
    };
  } else {};

in {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        verbatimConfig = ''
          seccomp_sandbox = 0
          cgroup_device_acl = [
            "/dev/kvm", "/dev/kvmfr0", "/dev/kvmfr1", "/dev/kvmfr2",
            "/dev/shm/looking-glass",
            "/dev/null", "/dev/full", "/dev/zero", "/dev/random",
            "/dev/urandom", "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc", "/dev/hpet", "/dev/vfio/vfio"
          ]
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # For looking-glass
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="ceri", GROUP="kvm", MODE="0660"
  '';

  # Bridge device (for work laptop)
  networking = vmNetworkOptions;
}