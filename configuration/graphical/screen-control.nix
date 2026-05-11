{ user, ... }:
{
  hardware.brillo.enable = true;
  users.users.${user}.extraGroups = [
    "video" # control screen brightness via brillo
  ];
  services.ddccontrol.enable = true;
  hardware.i2c.enable = true; # for ddcutil
}
