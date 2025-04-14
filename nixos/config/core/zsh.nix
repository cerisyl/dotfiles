{config, pkgs, lib, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Aliases: General
      ls      = "ls --color=auto";
      c       = "clear";
      home    = "cd ~";
      zshrc   = "code ~/.zshrc";
      zshfx   = "code ~/.zshfx";

      # Aliases: Websearch
      yt      = "youtube";
      wolfram = "wolframalpha";

      # Aliases: Package management

      # Aliases: Python
      py      = "python";
      pipin   = "python -m pip install";
      pipun   = "python -m pip uninstall";
      pyv     = "./.venv/bin/python";
      pyvin   = "pyv -m pip install";
      pyvun   = "pyv -m pip uninstall";

      # Aliases: Instant run
      chatter = "cd ~/code/sites/chatter && npm run dev";
      dalle   = "for file in *; do mv \"$file\" \"${file:0:26}.png\"; done";
      package = "~/itg/package.sh";

      # Aliases: NPM
      npmi    = "npm install";
      run     = "npm run";
      dev     = "npm run dev";
      deploy  = "npm run deploy";
      redev   = "npm run redev";
      update  = "ncu -i";
      #rev="printf 'Build %04d\n' $(git rev-list --count main)"

      # Aliases: RPL directories
      rpl     = "cd ~/code/rpl";
      www     = "cd ~/code/rpl/www";
    };
    history.size = 10000;
  };
}