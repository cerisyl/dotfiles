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
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ceri qemu-libvirtd -"
  ];
}