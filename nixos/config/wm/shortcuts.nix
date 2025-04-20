{ config, pkgs, lib, ... }: {
  xfconf.settings.xfce4-keyboard-shortcuts = {
    "commands/custom/override"  = true;
    # Kill current task
    "<Primary><Alt>Escape" = "xkill";
    # Lock computer
    "<Super>l" = "xflock4";
    # btop / Task manager
    "<Primary><Shift>Escape"    = "kitty --hold btop";
    # Windows key (rofi "start menu")
    "Super_L" = "rofi -show";
    # Emoji/symbol picker (rofimoji)
    "<Super>e" = "rofimoji";
    # Show clipboard history (rofi-greenclip)
    "<Super>c" = "rofi -modi \"clipboard:greenclip print\" -show clipboard -no-show-icons";
    # Show desktop toggle
    "<Super>d" = "sh /home/ceri/.config/xfce4/panel/genmon/showdesktop.sh";
    # Show file explorer
    "<Super>f" = "thunar";
  };
}
