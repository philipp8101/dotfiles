{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
    iconTheme.package = pkgs.adwaita-icon-theme;
    iconTheme.name = "Adwaita";
    cursorTheme.package = import ./Empty-Butterfly-cursor { inherit pkgs; };
    cursorTheme.name = "Empty-Butterfly-White-vr6";
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze-dark";
  };
  home.pointerCursor = {
    package = import ./Empty-Butterfly-cursor { inherit pkgs; };
    name = "Empty-Butterfly-White-vr6";
    gtk.enable = true;
    x11.enable = true;
  };
}
