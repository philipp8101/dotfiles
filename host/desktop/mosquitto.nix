{
  services.mosquitto = {
    enable = true;
    listeners = [{
      acl = [ "pattern readwrite #" ];
      port = 1883;
      omitPasswordAuth = true;
      settings.allow_anonymous = true;
    }];
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      1883 # mqtt
      3240 # usbip
      8080
    ];
  };
}
