{
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/4ba2d816-6e7b-4d50-a67f-6ceaf33823c8";
    allowDiscards = true;
    preLVM = true;
  };
}
