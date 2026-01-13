{ pkgs, config, ... }:
{
  services.mopidy = {
    enable = false;
    configuration = ''
      	    [jellyfin]
      	    hostname = http://localhost:8096
      	    username = jellyfin
      	    password = 123
      	    libraries = Music
      	    max_bitrate = 48000
      	    [audio]
      	    output = pulsesink server=127.0.0.1
      	'';
    extensionPackages = with pkgs; [
      mopidy-jellyfin
    ];
  };
  services.jellyfin = {
    enable = false;
    openFirewall = true;
  };
  services.gmediarender = {
    enable = true;
    # audioSink = "pipewiresink";
    # audioDevice = "default";
  };
  systemd.services.gmediarender.environment.HOME = "/tmp";
  networking.firewall.allowedTCPPorts = [
    8123 # homeassistant
    1883 # mqtt
    8099 # zigbee2mqtt
  ];
  services.zigbee2mqtt = {
    enable = true;
    settings = (import ./zigbee2mqtt.nix);
    # settings = {
    #   homeassistant = config.services.home-assistant.enable;
    #   permit_join = true;
    #   serial.port = "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_8e8b619b316cef1185ec99adc169b110-if00-port0";
    #   mqtt.server = "mqtt://127.0.0.1:1883";
    #   frontend.enable = true;
    #   serial.adapter = "ember";
    #   advanced.channel = 11;
    #   advanced.network_key = "73:3a:00:84:c1:5e:10:6b:d1:5c:ce:4e:f4:30:44:00";
    #   advanced.pan_id = "bc0e";
    #   advanced.ext_pan_id = "2e:c1:5a:e1:1d:1b:5b:99";
    # };
  };
  services.mosquitto = {
    enable = true;
    listeners = [
    {
      acl = [ "pattern readwrite #" ];
      omitPasswordAuth = true;
      settings.allow_anonymous = true;
      users.user = {
        acl = [ "readwrite #" ];
        password = "123";
      };
    }
    ];
  };
  services.tailscale = {
    enable = true;
    authKeyFile = "/etc/tailscale-secret";
  };
}
