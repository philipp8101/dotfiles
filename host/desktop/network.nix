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
}
