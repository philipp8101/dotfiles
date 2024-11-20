{ pkgs, config, ... }:
let
lib = pkgs.lib;
display = lib.types.submodule {
      options = {
        identifier = lib.mkOption {
          type = lib.types.str;
          example = "DP-1";
          description = "identifier for the display";
        };
        isPrimary = lib.mkOption {
          type = lib.types.bool;
          example = true;
          default = false;
          description = "is this display the primary one";
        };
        resolution = lib.mkOption {
          type = lib.types.str;
          default = "1920x1080";
          description = "resolution of the display";
        };
        refreshrate = lib.mkOption {
          type = lib.types.float;
          example = 144;
          default = 60;
          description = "refresh rate of the display";
        };
        offset = lib.mkOption {
          type = lib.types.str;
          example = "1920x0";
          default = "0x0";
        };
        scale = lib.mkOption {
          type = lib.types.int;
          example = 2;
          default = 1;
        };
      };
    };
in {
  options.displays = lib.mkOption {
    type = lib.types.listOf display;
    description = "list of all displays";
  };
  options.primaryDisplay = lib.mkOption {
    type = display;
    default = lib.lists.findFirst (a: a.isPrimary) null config.displays;
    description = "primary display, by default this value is derived from displays";
  };
  config.assertions = [
    {
      assertion = lib.lists.count (a: a.isPrimary) config.displays == 1;
      message = "must specify exactly one primary display";
    }
  ];
}
