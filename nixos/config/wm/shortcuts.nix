{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  # TODO: Put this in a util .nix file or something
  # Make life easier - prefixes a key in an attribute set
  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "${prefix}${name}" value);

  shortcuts = prependAttrs "commands/custom/" {
    "override"  = true;
    # Kill current task
    "<Primary><Alt>Escape" = "xkill";
    # Lock computer
    "<Super>l" = "xflock4";
    # btop / Task manager
    "<Primary><Shift>Escape" = "kitty --hold btop";
    # Windows key (toggle rofi "start menu")
    "Super_L" = "rofi -show";
    # Emoji/symbol picker (rofimoji)
    "<Super>e" = "rofimoji";
    # Show clipboard history (rofi-greenclip)
    "<Super>c" = "rofi -modi \"clipboard:greenclip print\" -show clipboard -no-show-icons";
    # Show desktop toggle
    "<Super>d" = "sh /home/ceri/.nix/extra/panel/showdesktop.sh";
    # Show file explorer
    "<Super>f" = "thunar";
  };
in {
  xfconf.settings.xfce4-keyboard-shortcuts = shortcuts;
}