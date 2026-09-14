{ lib, ... }:
let
  files = lib.attrNames (lib.filterAttrs (_: type: type == "regular") (builtins.readDir ./.));
  dirs = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.));
  nixFiles = lib.filter (f: lib.hasSuffix ".nix" f && !lib.hasSuffix "default.nix" f) files;
  imports = lib.map (f: ./${f}) (nixFiles ++ dirs);
in { imports = imports; }
