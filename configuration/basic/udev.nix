{
    services.udev = {
      enable = true;
      extraRules = builtins.concatStringsSep "\n" [
        # steelseries for headsetctl
        ''KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12c2", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"''
        # logic analyser
        ''SUBSYSTEM=="usb", ATTR{idVendor}=="0925", ATTR{idProduct}=="3881", MODE="0666", GROUP="plugdev"''
      ];
    };
}
