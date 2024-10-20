{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-calc ];
    package = pkgs.rofi;
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      "configuration" = {
        display-run = "";
        display-drun = "";
        display-window = "";
        drun-display-format = "{icon} {name}";
        font = "Inconsolata Nerd Font 12";
        modi = "window,run,drun";
        show-icons = true;
      };
      "*" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#${config.colorScheme.palette.base05}bb";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        highlight =mkLiteral "bold";
        spacing = mkLiteral "0px";
        width = mkLiteral "30%";
        height = mkLiteral "50%";
      };
      "window" = {
        border-radius = mkLiteral "24px";
        background-color = mkLiteral "#${config.colorScheme.palette.base00}bb";
      };
      "mainbox" = {
        padding = mkLiteral "12px";
        children = mkLiteral "[inputbar, message, listview]";
      };
      "inputbar" = {
        background-color = mkLiteral "#${config.colorScheme.palette.base01}bb";
        border-color = mkLiteral "#${config.colorScheme.palette.base02}bb";
        border = mkLiteral "2px";
        border-radius = mkLiteral "16px";
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        children = mkLiteral "[ prompt, entry ]";
      };
      "prompt" = {
        text-color = mkLiteral "#${config.colorScheme.palette.base05}bb";
      };
      "entry" = {
        placeholder = "Search";
        placeholder-color = mkLiteral "#${config.colorScheme.palette.base06}bb";
      };
      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = mkLiteral "16px";
        border-color = mkLiteral "#${config.colorScheme.palette.base00}bb";
        background-color = mkLiteral "#${config.colorScheme.palette.base00}bb";
      };
      "textbox" = {
        padding = mkLiteral "8px 24px";
      };
      "listview" = {
        background-color = mkLiteral "transparent";
        margin = mkLiteral "12px 0 0";
        lines = mkLiteral "8";
        columns = mkLiteral "1";
        fixed-height = false;
      };
      "element" = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "8px";
        background-color = mkLiteral "transparent";
        border-radius = mkLiteral "16px";
      };
      "element normal active" = {
        # text-color = mkLiteral "#${config.colorScheme.palette.base02}bb";
      };
      "element selected normal, element selected active" = {
        background-color = mkLiteral "#${config.colorScheme.palette.base02}bb";
        # text-color = mkLiteral "#${config.colorScheme.palette.base01}bb";
      };
      "element-icon" = {
        "size" = mkLiteral "1em";
        vertical-align = mkLiteral "0.5";
      };
      "element-text" = {
        text-color = mkLiteral "inherit";
      };
    };
  };
}
