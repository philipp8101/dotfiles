{ user, lib, ... }:
{
  config = {
    home.username = "${user}";
    home.homeDirectory = lib.mkForce "/home/${user}";
    home.stateVersion = "23.11"; # Please read the comment before changing.


    programs.home-manager.enable = true;
  };
  imports = [
    ./programs
  ];
}
