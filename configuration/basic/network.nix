{ pkgs, user, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = [ pkgs.networkmanager-openvpn ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
    };
  };
  users.users.${user}.extraGroups = [
    "networkmanager"
  ];
  services.tailscale.enable = true;
  networking.nameservers = [ "1.1.1.1" ];
}
