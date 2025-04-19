{ lib, helpers, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "bufjump";
  moduleName = "bufjump";
  packPathName = "bufjump";
  package = "bufjump-nvim";
  setup = ".setup";

  maintainers = [];
}
