{ config, pkgMap, theme, getThemeFile, homedir, lib, ... }: {
  programs.zsh = {
    enable = true;
    package = pkgMap.zsh;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # Plugins
    plugins = [
      {
        name = "fzf-tab";
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
        src = pkgMap.zsh-fzf-tab;
      }
    ];
    # Init
    initExtraBeforeCompInit = ''
      # Set up / source zinit
      # TODO: Remove the need for surpressing source output
      export ZINIT_HOME="${homedir}/.local/share/zinit/"
      if [ ! -d "$ZINIT_HOME" ]; then
        mkdir -p "$(dirname $ZINIT_HOME)"
      fi
      source ${pkgMap.zinit}/share/zinit/zinit.zsh > /dev/null 2>&1

      # Search engines
      ZSH_WEB_SEARCH_ENGINES=(
        netid "https://my.engr.illinois.edu/usersearch/index.asp?search="
        atlas "https://uofi.atlassian.net/wiki/search?text="
        tix "https://help.uillinois.edu/TDNext/Apps/Search/LookupItem?searchText="
      )

      # Add in snippets
      zinit snippet OMZL::clipboard.zsh
      zinit snippet OMZL::directories.zsh
      zinit snippet OMZL::functions.zsh
      zinit snippet OMZL::termsupport.zsh
      zinit snippet OMZP::extract
      #zinit snippet OMZP::git <- clashes with gpu command
      zinit snippet OMZP::gitignore
      zinit snippet OMZP::tldr
      zinit snippet OMZP::sudo
      zinit snippet OMZP::web-search

      zinit cdreplay -q

      # Keybindings
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      # Forward/backward word + wordchars
      local WORDCHARS='*?_[]~=&;!#$%^(){}<>'
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # Mute beeps
      unsetopt BEEP
    '';
    # History
    history = {
      size          = 10000;
      save          = 10000;
      append        = true;
      share         = true;
      ignoreSpace   = true;
      saveNoDups    = true;
      ignoreDups    = true;
      ignoreAllDups = true;
      findNoDups    = true;
    };
    initExtra = ''
      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu select

      # Shell integrations
      eval "$(fzf --zsh)"

      # Functions
      fpath=(~/.nix/extra/zshfx $fpath);
      autoload -U $fpath[1]/*(.:t)

      # Init omp
      eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/theme.json)"
    '';
    # Aliases
    shellAliases = {
      # General
      ls      = "ls --color=auto";
      c       = "clear";
      home    = "cd ~";
      fetch   = "fastfetch";
      ff      = "fastfetch";

      # Websearch
      yt      = "youtube";
      wolfram = "wolframalpha";

      # Package management
      rebuild = ''(sudo nixos-rebuild switch --flake ~/.nix/. &> ~/.switch.log || 
      (cat ~/.switch.log | grep --color error && false)) && xfce4-panel -r'';
      rbl     = "rebuild";
      upgrade = ''cd ~/.nix && (sudo nix flake update && git commit -am "Update flake" && rebuild) ||
      (echo "Some error occured! Check ~/.switch.log!")'';
      homelog = "journalctl -xe --unit home-manager-ceri";

      # Virtual machine + GPU management
      looking-glass = "looking-glass-client -s -m 97 -F";
      lg      = "looking-glass";
      win11   = ''gpu vm && virsh --connect qemu:///system start "win11" && lg'';

      # Python
      py        = "python";
      pipin     = "python -m pip install";
      pipun     = "python -m pip uninstall";
      init-venv = "python -m venv .venv"; 
      pyv       = "./.venv/bin/python";
      pyvin     = "pyv -m pip install";
      pyvun     = "pyv -m pip uninstall";

      # Instant run
      chatter = "cd ~/code/sites/chatter && npm run dev";
      dalle   = "for file in *; do mv \"$file\" \"${file:0:26}.png\"; done";
      package = "~/itg/package.sh";

      # NPM TODO: remove
      npmi    = "npm install";
      run     = "npm run";
      dev     = "npm run dev";
      deploy  = "npm run deploy";
      redev   = "npm run redev";

      # Work
      tdx       = "floorp https://help.uillinois.edu/TDNext/Home/Desktop/Default.aspx";
      iris      = "floorp https://iris.techservices.illinois.edu";
      ipam      = "floorp https://ipam.illinois.edu/ui";
      jenk      = "floorp https://helptools-importer.engrit.illinois.edu";
      lens      = "floorp https://ctweb1.techservices.illinois.edu/ipm";
      filter    = "floorp https://my.engr.illinois.edu/cts/macfilter.asp";
      ibuy      = "floorp https://www.busfin.uillinois.edu/applications/i_buy";
      purchase  = "floorp https://my.engr.illinois.edu/login.asp?/purchasing/index.asp";
    };
  };
}