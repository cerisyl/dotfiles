{ config, pkgMap, theme, getThemeFile, lib, ... }: let
  mediaPlayer = "vlc.desktop";
  imgViewer   = "imv-dir.desktop";
  browser     = "floorp.desktop";
  editor      = "code.desktop";
  archiver    = "engrampa.desktop";
  fileAssociations = {
    # audio
    "audio/flac"      = mediaPlayer;
    "audio/midi"      = mediaPlayer;
    "audio/x-midi"    = mediaPlayer;
    "audio/mpeg"      = mediaPlayer; #mp4
    "audio/ogg"       = mediaPlayer;
    "audio/x-vorbis"  = mediaPlayer;
    "audio/wav"       = mediaPlayer;
    # images
    "image/avif"    = imgViewer;
    "image/bmp"     = imgViewer;
    "image/x-bmp"   = imgViewer;
    "image/jpeg"    = imgViewer;
    "image/jpg"     = imgViewer;
    "image/gif"     = imgViewer;
    "image/png"     = imgViewer;
    "image/svg+xml" = imgViewer;
    "image/tiff"    = imgViewer;
    "image/webp"    = imgViewer;
    "image/x-icon"  = imgViewer;
    # browser / web
    "x-scheme-handler/http"         = browser;
    "x-scheme-handler/https"        = browser;
    "x-scheme-handler/chrome"       = browser;
    "x-scheme-handler/spotify"      = browser;
    "application/pdf"               = browser;
    "application/x-extension-htm"   = browser;
    "application/x-extension-html"  = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml"         = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht"   = browser;
    # videos
    "video/x-flv"       = mediaPlayer;
    "video/mp4"         = mediaPlayer;
    "video/mov"         = mediaPlayer;
    "video/quicktime"   = mediaPlayer;
    "video/vnd.avi"     = mediaPlayer;
    "video/webm"        = mediaPlayer;
    "video/x-ms-wmv"    = mediaPlayer;
    "video/x-matroska"  = mediaPlayer; # mkv
    # code
    "text/x-c"                  = editor;
    "text/x-c++"                = editor;
    "text/css"                  = editor;
    "text/csv"                  = editor;
    "text/x-diff"               = editor;
    "text/x-haskell"            = editor;
    "text/html"                 = editor;
    "text/x-java"               = editor;
    "text/javascript"           = editor;
    "application/json"          = editor;
    "text/markdown"             = editor;
    "text/x-makefile"           = editor;
    "text/x-nix"                = editor;
    "text/x-typescript"         = editor;
    "text/x-perl"               = editor;
    "application/x-php"         = editor;
    "text/plain"                = editor;
    "text/x-pug"                = editor;
    "text/x-python"             = editor;
    "text/x-sass"               = editor;
    "text/x-scss"               = editor;
    "application/x-sh"          = editor;
    "text/tab-separated-values" = editor;
    "application/xml"           = editor;
    # archiving
    "application/x-7z-compressed"   = archiver;
    "application/x-bzip"            = archiver;
    "application/x-bzip2"           = archiver;
    "application/gzip"              = archiver;
    "application/x-iso9660-image"   = archiver;
    "application/vnd.rar"           = archiver;
    "application/x-tar"             = archiver;
    "application/zip"               = archiver;
    "application/x-zip-compressed"  = archiver;
    # windows executables
    "application/vnd.microsoft.portable-executable" = "wine.desktop";
    "application/x-msdownload" = "wine.desktop";
    # misc applications
    "x-scheme-handler/discord" = "discord.desktop";
    "x-scheme-handler/magnet"  = "deluge.desktop";
    # TODO: direct open win11 vm for things like xlsx?
  };
in {
  xdg = {
    mimeApps = {
      enable = true;
      associations.added  = fileAssociations;
      defaultApplications = fileAssociations;
    };
    configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      WebBrowser=custom-WebBrowser
    '';
  };
}