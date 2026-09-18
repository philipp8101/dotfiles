{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/tank" = {
    device = "192.168.178.178:/tank";
    fsType = "nfs4";
  };
  fileSystems."/tank/savegames" = {
    device = "192.168.178.178:/tank/savegames";
    fsType = "nfs4";
  };
  fileSystems."/tank/documents" = {
    device = "192.168.178.178:/tank/documents";
    fsType = "nfs4";
  };
  fileSystems."/tank/con" = {
    device = "192.168.178.178:/tank/con";
    fsType = "nfs4";
  };
}
