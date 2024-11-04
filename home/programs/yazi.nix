{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      manager.keymap = [
        { run = "arrow 1"; on = [ "e"]; }
        { run = "arrow -1"; on = [ "o"]; }
        { run = "leave"; on = [ "n"]; }
        { run = "enter"; on = [ "i"]; }
        { run = "quit"; on = [ "q"]; }
      ];
    };
  };
}
