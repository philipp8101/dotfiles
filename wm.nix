{ config, pkgs, inputs, ... }:

let
bg = pkgs.stdenv.mkDerivation {
  name = "modified-wallpaper";
  src = ./nixos-wallpaper-catppuccin-macchiato.svg;
  buildInputs = [ pkgs.gnused ];
  buildCommand = ''
    mkdir -p $out
    sed -e 's/#181926/#${config.colorScheme.palette.base01}/g' -e 's/#f4dbd6/#${config.colorScheme.palette.base06}/g' -e 's/#8bd5ca/#${config.colorScheme.palette.base0C}/g' -e 's/#5b6078/#${config.colorScheme.palette.base04}/g' -e 's/#24273a/${config.colorScheme.palette.base00}/g' $src > $out/modified-wallpaper.svg
    '';
};
cursor = pkgs.stdenv.mkDerivation {
  name = "Empty-Butterfly-White-vr6";
  src = builtins.fetchurl {
    name = "Empty-Butterfly-White-vr6-Linux.zip";
    url = "https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1678767622/Empty-Butterfly-White-vr6-Linux.zip?response-content-disposition=attachment%3B%2520Empty-Butterfly-White-vr6-Linux.zip&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20240628%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240628T172908Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=ed369deffc79b1ff734abd5fc8f5e19d9e463201cff3dbb3e95631d41ba41dd5";
    sha256 = "6260fbcb8c935500b206d69bc580b5ef620c63b38d34b894d156263da2ececac";
  };
  buildCommand = ''
    mkdir -p $out/share/icons/
    ${pkgs.unzip}/bin/unzip $src
    cp -r ./Empty-Butterfly-White-vr6-Linux/Empty-Butterfly-White-vr6/ $out/share/icons/
  '';
};

in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./home/polybar.nix
    ./home/alacritty.nix
    ./home/rofi.nix
    ./home/i3.nix
    ./home/hyprland.nix
    ./home/waybar.nix
  ];
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inconsolata
    inconsolata-nerdfont
  ];

  home.file = {
    ".background-image".source = "${bg.outPath}/modified-wallpaper.svg";
  };

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
    # platformTheme.name = "adwaita";
    style.name = "Breeze";
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

  xdg.mimeApps.defaultApplications = {
    "text/*" = [ "neovim.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "image/*" = [ "eog.desktop" ];
    "application/pdf" = [ "evince.desktop" ];
  };

  xdg.desktopEntries = {
    neovim = {
      name = "Neovim";
      genericName = "Text editor";
      icon = "nvim";
      exec = "kitty nvim %U";
      mimeType = [ "text/*" ];
    };
    nvim = {
      name = "nvim";
      noDisplay = true;
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Inconsolata Nerd Font";
      size = 14;
    };
    settings = {
      background_opacity = "0.8";
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      globals = {
        frame_color = "#${config.colorScheme.palette.base04}";
        separator_color = "frame";
      };
      urgency_low = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
        frame_color = "#${config.colorScheme.palette.base03}";
      };
      urgency_normal = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
      };
      urgency_critical = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base0F}";
        frame_color = "#${config.colorScheme.palette.base08}";
      };
    };
  };

  services.picom = {
    enable = true;
    # backend = "glx";
    fade = true;
    fadeDelta = 4;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 3;
      };
    };
  };

}
