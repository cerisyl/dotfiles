{ inputs, config, pkgMap, theme, getThemeFile, lib, ... }: {
  imports = [inputs.nixcord.homeManagerModules.nixcord];

  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    quickCss = builtins.readFile (getThemeFile "discord.css");

    config = {
      useQuickCss = true;
      frameless = true;
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
        clientTheme = {
          enable = true;
          color = "0f0f0f";
        };
      };
    };
  };
}


