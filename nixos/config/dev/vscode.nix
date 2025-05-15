{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.vscode = {
    enable        = true;
    package       = pkgMap.vscode-fhs;
    # TODO: Offload online config
  };
}
