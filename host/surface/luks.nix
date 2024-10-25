{
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/43bd97d7-e8b3-4443-b993-61874ebc8b8a";
    allowDiscards = true;
    preLVM = true;
  };
}
