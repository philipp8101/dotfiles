{ lib, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "bufjump";
  moduleName = "bufjump";
  package = "bufjump-nvim";
  setup = ".setup";

  maintainers = [];
}
