{ config, pkgMap, theme, getThemeFile, lib, ... }:
if pkgMap ? "vesktop" then {
  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop = {
      enable  = true;
      package = pkgMap.vesktop;
    };

    quickCss = builtins.readFile (getThemeFile "discord.css");

    config = {
      useQuickCss = true;
      frameless   = false;
      plugins = {
        alwaysTrust.enable          = true;
        betterGifPicker.enable      = true;
        betterSessions.enable       = true;
        callTimer.enable            = true;
        copyFileContents.enable     = true;
        clearURLs.enable            = true;
        crashHandler.enable         = true;
        disableCallIdle.enable      = true;
        fixImagesQuality.enable     = true;
        fixYoutubeEmbeds.enable     = true;
        noReplyMention.enable       = true;
        noUnblockToJump.enable      = true;
        shikiCodeblocks.enable      = true;
        unindent.enable             = true;
        userMessagesPronouns.enable = true;
        validUser.enable            = true;
        youtubeAdblock.enable       = true;
      };
    };
  };
}
