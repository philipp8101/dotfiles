{ lib, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "harpoon2";
  moduleName = "harpoon";
  package = "harpoon2";
  setup = ":setup";

  maintainers = [];

  settingsExample = {
    "some_name" = {
      add = lib.nixvim.mkRaw ''function(possible_value) return { value = ... , context = ... } end'';
      select = lib.nixvim.mkRaw ''function(list_item, list, options) ... end'';
    };
  };
}
