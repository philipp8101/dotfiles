{
  services.kmonad = {
    enable = true;
    keyboards.surface-typecover = {
      name = "surface-typecover";
      device = "/dev/input/by-id/usb-Microsoft_Surface_Type_Cover-event-kbd";
      extraGroups = [ "uinput" ];
      defcfg = {
        enable = true;
        fallthrough = true;
      };
      config = ''
        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]   
          caps a    s    d    f    g    h    j    k    l    ;    '    \   
          lsft 102d z    x    c    v    b    n    m    ,    .    /    rsft
        )
        (deflayer base
          tab       q    d    r    w    b    j    f    u    p    ö    ü    ]   
          caps      a    s    h    t    g    y    n    e    o    i    ä    \   
          lsft 102d z    x    m    c    v    k    l    ,    .    /    rsft
        )
      '';
    };
  };
}
