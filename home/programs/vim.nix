{ pkgs, self, system, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    self.packages.${system}.nixvim
  ];
}
