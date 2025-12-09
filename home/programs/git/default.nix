{ config, pkgs, isDarwin ? false, isLinux ? false, ... }:

{
  programs.git = {
    enable = true;

    # Core behavior
    settings = {

      user = {
        name = "Flizzeri";
        email = "filippo.lizzeri@gmail.com";
      };

      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        autocrlf = "input";
        whitespace = "trailing-space,space-before-tab";
      };

      pull = {
        rebase = true;
        ff = "only";
      };

      rebase = {
        autoStash = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      branch = {
        sort = "-committerdate";
      };

      diff = {
        colorMoved = "default";
        algorithm = "histogram";
      };

      merge = {
        conflictStyle = "zdiff3";
      };

      rerere = {
        enabled = true;
      };

      # Make `git status` snappy in big repos
      feature = {
        manyFiles = true;
      };

      # Quality-of-life aliases (keep few; you can add later)
      aliases = {
        st = "status -sb";
        co = "checkout";
        sw = "switch";
        br = "branch -vv";
        cm = "commit";
        ca = "commit --amend";
        df = "diff";
        lg = "log --graph --decorate --oneline --abbrev-commit";
        lga = "log --graph --decorate --oneline --abbrev-commit --all";
        unstage = "restore --staged";
        last = "log -1 --stat";
      };
    };

    ignores = [
      # OS cruft
      ".DS_Store"
      "Thumbs.db"

      # Editors / tooling
      ".vscode/"
      ".idea/"
      "*.swp"
      "*.swo"

      # Direnv
      ".direnv/"
      ".envrc.local"

      # Node / JS
      "node_modules/"
      "dist/"
      "build/"
      ".turbo/"
      ".next/"
      ".parcel-cache/"

      # Python
      "__pycache__/"
      "*.pyc"
      ".venv/"
      "venv/"
      ".mypy_cache/"
      ".ruff_cache/"

      # Rust
      "target/"

      # Go
      "bin/"
    ];
  };

  # MacOS: git credential helper
  programs.git.settings.credential =
    if isDarwin then { helper = "osxkeychain"; }
    else { };

  programs.delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = false;
        syntax-theme = "Monokai Extended"; # change to match your theme tastes
    };

    enableGitIntegration = true;
  };

  home.packages = with pkgs; [
    delta
  ];
}

