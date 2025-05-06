{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  xdg.configFile."keepassxc/keepassxc.ini".text = ''
    [General]
    ConfigVersion=2

    [PasswordGenerator]
    AdditionalChars=!@#?%_-+&
    ExcludedChars=
    LowerCase=true
    UpperCase=true
    AdvancedMode=true
    Length=20
    WordCount=3
    WordSeparator=-
    Braces=false
    Punctuation=false
    Quotes=false
    Dashes=false
    Math=false
    ExcludeAlike=true
    Logograms=false
    EnsureEvery=false
    Type=0

    [GUI]
    ApplicationTheme=dark
    CompactMode=true
    HidePasswords=false
    HideToolbar=false
    ToolButtonStyle=0
    TrayIconAppearance=colorful
    HidePreviewPanel=true
    ColorPasswords=true
    MinimizeOnClose=true
    MinimizeOnStartup=true
    ShowTrayIcon=true
    MinimizeToTray=true
    MonospaceNotes=true

    [Browser]
    CustomProxyLocation=
    Enabled=true
    SearchInAllDatabases=true

    [Security]
    IconDownloadFallback=true
    ClearClipboardTimeout=15
  '';

  # TODO: Uncomment after 25.05 release
  # programs.keepassxc = {
  #   enable = true;
  #   settings = {
  #     General = {
  #       ConfigVersion = 2;
  #     };
  #     PasswordGenerator = {
  #       AdditionalChars = "!@#?%_-+&";
  #       ExcludedChars   = "";
  #       LowerCase       = true;
  #       UpperCase       = true;
  #       AdvancedMode    = true;
  #       Length          = 20;
  #       WordCount       = 3;
  #       WordSeparator   = "-";
  #       Braces          = false;
  #       Punctuation     = false;
  #       Quotes          = false;
  #       Dashes          = false;
  #       Math            = false;
  #       ExcludeAlike    = true;
  #       Logograms       = false;
  #       EnsureEvery     = false;
  #       Type            = 0;
  #     };
  #     GUI = {
  #       ApplicationTheme    = "dark";
  #       CompactMode         = true;
  #       HidePasswords       = false;
  #       HideToolbar         = false;
  #       ToolButtonStyle     = 0;
  #       TrayIconAppearance  = "colorful";
  #       HidePreviewPanel    = true;
  #       ColorPasswords      = true;
  #       MinimizeOnClose     = true;
  #       MinimizeOnStartup   = true;
  #       ShowTrayIcon        = true;
  #       MinimizeToTray      = true;
  #       MonospaceNotes      = true;
  #     };
  #     Browser = {
  #       Enabled               = true;
  #       SearchInAllDatabases  = true;
  #     };
  #     Security = {
  #       ClearClipboardTimeout = 15;
  #       IconDownloadFallback  = true;
  #     };
  #   };
  # };
}