{
  services.kmonad = {
    enable = true;
    keyboards.surface-typecover = {
      name = "surface-typecover";
      device = "/dev/input/by-id/usb-Microsoft_Surface_Type_Cover-event-kbd";
      defcfg = {
        enable = true;
        fallthrough = true;
      };
      config = [
        "(defsrc ...)"
      ];
    };
  };
}
