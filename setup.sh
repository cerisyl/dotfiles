# git clone -b nix https://github.com/cerisyl/dotfiles

# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount dotfiles/disko.nix

# cd dotfiles
# nixos-install --flake .#host