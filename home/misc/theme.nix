{ pkgs, config, ... }:
let
cursor = pkgs.callPackage ./Empty-Butterfly-cursor {};
in {
  gtk = {
    enable = config.gui;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
    iconTheme.package = pkgs.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    cursorTheme.package = cursor;
    cursorTheme.name = "Empty-Butterfly-White-vr6";
  };

  qt = {
    enable = config.gui;
    platformTheme.name = "kde";
    style.name = "breeze-dark";
  };
  home.pointerCursor = {
    package = cursor;
    name = "Empty-Butterfly-White-vr6";
    gtk.enable = config.gui;
    x11.enable = config.gui;
  };
}
