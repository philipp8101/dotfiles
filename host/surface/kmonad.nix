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
          tab       q    w    e    r    t    y    u    i    o    p    [    ]   
          caps      a    s    d    f    g    h    j    k    l    ;    '    \   
          lsft 102d z    x    c    v    b    n    m    ,    .    /    rsft
          ralt
        )
        (deflayer base
          tab       q    d    r    w    b    j    f    u    p    ;    [    ]   
          esc       a    s    h    t    g    z    n    e    o    i    '    \   
          lsft 102d y    x    m    c    v    k    l    ,    .    /    rsft
          (layer-toggle symbol)
        )
        (deflayer symbol
          -         (around ralt q)    (around sft 2)    (around ralt ])    `    102d    (around sft 102d)    $    [    (around ralt -)    -    -    -   
          -         '    min    (around sft 0)    (around sft 8)    (around ralt 7)    (around ralt 0)    (around sft 9)    (around sft 7)    ;    (around sft .)    -    -   
          -    -    (around sft =)    (around sft \\)    (around sft ])    (around sft 5)    (around ralt 8)    (around ralt 9)    (around sft 6)    !    (around ralt 102d)    (around sft -)    -
          -
        )
      '';
    };
  };
}
