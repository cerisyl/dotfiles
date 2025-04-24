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
    # Capture full-screen screenshot (xfce4-screenshooter)
    "<Primary><Shift>numbersign" = "mkdir -p $XDG_SCREENSHOTS_DIR/$(date +%Y-%m) && xfce4-screenshooter -f -c -s \"$XDG_SCREENSHOTS_DIR/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png\"";
    # Capture area screenshot (xfce4-screenshooter)
    "<Primary><Shift>dollar" = "mkdir -p $XDG_SCREENSHOTS_DIR/$(date +%Y-%m) && xfce4-screenshooter -r -c -s \"$XDG_SCREENSHOTS_DIR/$(date +%Y-%m)/$(date +%Y-%m-%d_%H-%M-%S).png\"";
    # Capture area screenshot with OCR (xfce4-screenshooter + tesseract)
    "<Primary><Shift>O" = "xfce4-screenshooter -r -s /tmp/save.png && tesseract /tmp/save.png - | xclip";
  };
in {
  xfconf.settings.xfce4-keyboard-shortcuts = shortcuts;
}