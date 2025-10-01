{ lib, helpers, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "harpoon2";
  moduleName = "harpoon";
  package = "harpoon2";
  setup = ":setup";

  maintainers = [];

  settingsExample = {
    "some_name" = {
      add = helpers.mkRaw ''function(possible_value) return { value = ... , context = ... } end'';
      select = helpers.mkRaw ''function(list_item, list, options) ... end'';
    };
  };
}
