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
      config = ''
        (defsrc
          esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12        ssrq slck pause
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc  ins  home pgup  nlck kp/  kp*  kp-
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret   del  end  pgdn  kp7  kp8  kp9  kp+
          caps a    s    d    f    g    h    j    k    l    ;    '    \                          kp4  kp5  kp6
          lsft 102d z    x    c    v    b    n    m    ,    .    /    rsft            up         kp1  kp2  kp3  kprt
          lctl lmet lalt           spc                 ralt rmet cmp  rctl       left down rght  kp0  kp.
        )
        (deflayer base
          esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12        ssrq slck pause
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc  ins  home pgup  nlck kp/  kp*  kp-
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret   del  end  pgdn  kp7  kp8  kp9  kp+
          caps a    s    d    f    g    h    j    k    l    ;    '    \                          kp4  kp5  kp6
          lsft 102d z    x    c    v    b    n    m    ,    .    /    rsft            up         kp1  kp2  kp3  kprt
          lctl lmet lalt           spc                 ralt rmet cmp  rctl       left down rght  kp0  kp.
        )
      '';
    };
  };
}
