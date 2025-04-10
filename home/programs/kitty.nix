{
  programs.kitty = {
    enable = true;
    font = {
      name = "Inconsolata Nerd Font";
      size = 14;
    };
    settings = {
      background_opacity = "0.8";
    };
    extraConfig = ''
    map ctrl+shift+p>f kitten hints --type path --program @
    '';
  };
}
