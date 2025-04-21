# Run after sudo su
# Initial build
git clone -b nix https://github.com/cerisyl/dotfiles
cd dotfiles
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount dotfiles/disko.nix
nixos-generate-config --root /mnt
cp .setup/configuration.nix /mnt/etc/nixos/configuration.nix
nixos-install
# Reboot...