{ self, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    self.nixvim
  ];
}
