{ config, pkgs, inputs, user, self, system, ... }:
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./fonts.nix
    ./git.nix
    ./hyprland.nix
    ./kitty.nix
    ./mpv.nix
    ./nix-colors.nix
    ./rofi.nix
    ./theme.nix
    ./tmux.nix
    ./vim.nix
    ./waybar.nix
    ./xkblayout.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  programs.home-manager.enable = true;
}
