{ config, lib, pkgs, ... }: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # For looking-glass
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="ceri", GROUP="kvm", MODE="0660"
  '';
}