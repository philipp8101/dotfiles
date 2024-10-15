{ pkgs, ... }:
let
cursor = pkgs.stdenv.mkDerivation {
  name = "Empty-Butterfly-White-vr6";
  # source https://store.kde.org/p/2002505
  src = ./Empty-Butterfly-White-vr6-Linux.zip;
  # builtins.fetchurl {
  #  name = "Empty-Butterfly-White-vr6-Linux.zip";
  #  url = "";
  #  sha256 = "6260fbcb8c935500b206d69bc580b5ef620c63b38d34b894d156263da2ececac";
  #};
  buildCommand = ''
    mkdir -p $out/share/icons/
    ${pkgs.unzip}/bin/unzip $src
    cp -r ./Empty-Butterfly-White-vr6-Linux/Empty-Butterfly-White-vr6/ $out/share/icons/
  '';
};
in
{
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
    iconTheme.package = pkgs.adw-gtk3;
    iconTheme.name = "adw-gtk3-dark";
    cursorTheme.package = cursor;
    cursorTheme.name = "Empty-Butterfly-White-vr6";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  home.pointerCursor = {
    package = cursor;
    name = "Empty-Butterfly-White-vr6";
    gtk.enable = true;
    x11.enable = true;
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/desktop/input-sources".sources = "[('xkb', 'de')]";
  };
}
