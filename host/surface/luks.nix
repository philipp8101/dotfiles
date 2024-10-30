{ config, ... }:
{
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/34312552-2224-4643-90d9-119000ee7c36";
    allowDiscards = true;
    preLVM = true;
  };
}
