{
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      extraPools = [ "tank" ];
      # list of encrypted datasets that should be mounted on boot
      # defaults to true which means all encrypted datasets will be mounted
      # https://github.com/NixOS/nixpkgs/blob/f771eb401a46846c1aebd20552521b233dd7e18b/nixos/modules/tasks/filesystems/zfs.nix#L391
      requestEncryptionCredentials = [ ];
    };
  };
}
