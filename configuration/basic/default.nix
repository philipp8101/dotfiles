{ lib, ... }:
let
  files = lib.attrNames (builtins.readDir ./.);
  nixFiles = lib.filter (f: lib.hasSuffix ".nix" f && !lib.hasSuffix "default.nix" f) files;
  imports = lib.map (f: ./${f}) nixFiles;
in { imports = imports; }
