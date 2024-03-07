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
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./home/polybar.nix
    ./home/alacritty.nix
    ./home/rofi.nix
    ./home/i3.nix
    ./home/hyprland.nix
  ];

  home.file = {
    ".background-image".source = "${bg.outPath}/modified-wallpaper.svg";
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita";
    cursorTheme.name = "Adwaita";
    iconTheme.name = "Adwaita";
  };

  xresources.properties = {
    "Xcursor.theme" = "Adwaita";
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
