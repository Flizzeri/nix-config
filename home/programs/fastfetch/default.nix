{ ... }:
{
  programs.fastfetch.enable = true;

  xdg.configFile."fastfetch/config.jsonc".source =
    ./fastfetch/config.jsonc;
}

