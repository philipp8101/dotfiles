{ pkgs, user, ... }:
{
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users.${user}.extraGroups = [
    "wireshark"
  ];
}
