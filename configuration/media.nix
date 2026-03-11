{ config, inputs, ... }:
{
  services.jellyfin.enable = true;
  services.jellyfin.group = "render";
  networking.firewall.allowedTCPPorts = [ 8096 ];
}
