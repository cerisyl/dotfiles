# $1 - hostname

# git clone -b nix https://github.com/cerisyl/dotfiles
git clone -b nix https://github.com/cerisyl/dotfiles
cd dotfiles
cp /etc/nixos/hardware-configuration.nix nixos/hosts/$1/hardware-configuration.nix
nixos-install --flake .#$1