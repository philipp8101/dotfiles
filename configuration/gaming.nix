{ pkgs, ... }:
{
  specialisation = {
    gaming.configuration = {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
      environment.systemPackages = with pkgs; [
        lutris
        bottles
        prismlauncher
      ];
    };
    default.configuration = {};
  };
}
