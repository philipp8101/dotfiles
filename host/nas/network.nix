{
  networking = {
    hostId = "9d2aff73";
    hostName = "nas";
  };
  systemd.network.networks."50-wg0".address = [
    "fd31:bf08:57cb::9/128"
    "10.0.1.9/32"
  ];
}
