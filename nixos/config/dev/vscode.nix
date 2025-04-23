{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.vscode = {
    enable        = true;
    package       = pkgMap.vscode-with-extensions;
    # TODO: Offload online config
  };
}
