{ config, ... }:
{
  sops.secrets.wg-key = {
    format = "binary";
    mode = "640";
    owner = "systemd-network";
    group = "systemd-network";
  };

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.useNetworkd = true;

  systemd.network = {
    enable = true;

    networks."50-wg0" = {
      matchConfig.Name = "wg0";

    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };

      wireguardConfig = {
        # ensure file is readable by `systemd-network` user
        PrivateKeyFile = config.sops.secrets.wg-key.path;

        # To automatically create routes for everything in AllowedIPs,
        # add RouteTable=main
        RouteTable = "main";

        # FirewallMark marks all packets send and received by wg0 
        # with the number 42, which can be used to define policy rules on these packets. 
        FirewallMark = 42;
      };
      wireguardPeers = [
        {
          # server
          PublicKey = "gpeoh2DNYwAogP77HDgvfSuKNObeMv1R9KKhznJ2LFU=";
          AllowedIPs = [
            "fd31:bf08:57cb::9/120"
            "10.0.1.0/24"
          ];
          Endpoint = "152.53.245.229:51820";

          # RouteTable can also be set in wireguardPeers
          # RouteTable in wireguardConfig will then be ignored.
          # RouteTable = 1000;
        }
      ];
    };
  };

}
