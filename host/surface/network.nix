{
  networking = {
    hostId = "dda0a13d";
    hostName = "surface";
  };
  systemd.network.networks."50-wg0".address = [
    "fd31:bf08:57cb::10/128"
    "10.0.1.10/32"
  ];
}
