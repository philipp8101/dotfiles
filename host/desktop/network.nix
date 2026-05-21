{ pkgs, ... }:
{
  networking = {
    hostId = "e52e59bb";
    hostName = "desktop";
    # networkmanager.dispatcherScripts = 
    #   let source = pkgs.writeText "hook" ''
    #   case "$2" in
    #     vpn-up)
    #       echo "$1:$2: running vpn up hook"
    #       ;;
    #     vpn-down|vpn-pre-down)
    #       echo "$1:$2: running vpn (pre) down hook"
    #       ;;
    #     esac
    #   '';
    #   in [ 
    #   { type = "pre-down"; inherit source; }
    #   { inherit source; }
    #   ];
  };
  systemd.network.networks."50-wg0".address = [
    "fd31:bf08:57cb::8/128"
    "10.0.1.8/32"
  ];
}
