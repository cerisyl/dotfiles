{ config, pkgMap, homedir, lib, ... }: {
  # Load our fonts
  home.activation.loadFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${homedir}/.local/share/fonts"
    ${pkgMap.unzip}/bin/unzip -qq -o "${homedir}/.nix/extra/fonts.zip" -d "${homedir}/.local/share/fonts"
  '';
}