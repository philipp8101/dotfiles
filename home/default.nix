{ config, pkgs, inputs, user, self, system, ... }:
{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  home.packages = [
    self.packages.${system}.nixvim
  ];

  programs.home-manager.enable = true;
}
