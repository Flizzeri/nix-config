# home/programs/zsh.nix
{ config, pkgs, lib, ... }:

let
  init = lib.concatStringsSep "\n" [
    ''
      # Shell Options
      setopt AUTO_CD
      setopt CORRECT
      setopt NO_BEEP

      # History options not covered by HM history module
      setopt HIST_VERIFY
      setopt APPEND_HISTORY
      setopt INC_APPEND_HISTORY
    ''

    ''
      # Functions
      mkcd() {
        mkdir -p "$1" && z "$1"
      }

      search() {
        rg --color=always --line-number --no-heading --smart-case "$@" | fzf --ansi
      }

      ff() {
        local file
        file=$(fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')
        [ -n "$file" ] && nvim "$file"
      }
    ''

    ''
      # FZF keybindings
      if command -v fzf &> /dev/null; then
        source <(fzf --zsh) 2>/dev/null || true
      fi
    ''

    ''
      # Fallback prompt if starship is absent
      if ! command -v starship &> /dev/null; then
        PROMPT='%F{yellow}%~%f %F{green}❯%f '
      fi
    ''
  ];
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    envExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
      export PAGER="less -FRX"

      export LANG=en_US.UTF-8
      export LC_ALL=en_US.UTF-8

      export DIRENV_LOG_FORMAT=""
    '';

    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
    };

    completionInit = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    '';

    shellAliases = {
      ll = "eza -lah --icons --git";
      la = "eza -a --icons";
      ls = "eza --icons";
      tree = "eza --tree --icons";

      ".." = "cd ..";
      "..." = "cd ../..";

      gs = "git status";
      gd = "git diff";
      gco = "git checkout";
      gl = "git log --oneline --graph --decorate";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull";

      cat = "bat --style=plain";

      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      v = "nvim";
      vim = "nvim";
    };

    initContent = init;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config.global.warn_timeout = "2m";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".source = ./starship.toml;
}

