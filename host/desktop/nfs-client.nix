{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/tank" = {
    device = "192.168.178.178:/tank";
    fsType = "nfs4";
  };
}
