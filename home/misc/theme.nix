{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
    iconTheme.package = pkgs.adw-gtk3;
    iconTheme.name = "adw-gtk3-dark";
    cursorTheme.package = import ./Empty-Butterfly-cursor { inherit pkgs; };
    cursorTheme.name = "Empty-Butterfly-White-vr6";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  home.pointerCursor = {
    package = import ./Empty-Butterfly-cursor { inherit pkgs; };
    name = "Empty-Butterfly-White-vr6";
    gtk.enable = true;
    x11.enable = true;
  };
}
