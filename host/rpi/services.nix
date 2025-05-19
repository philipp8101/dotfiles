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
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
      "homeassistant_hardware"
      "zha"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };
  networking.firewall.allowedTCPPorts = [ 8123 1883 ];
  services.zigbee2mqtt = {
    enable = !config.services.home-assistant.enable;
    settings = {
      homeassistant = config.services.home-assistant.enable;
      permit_join = true;
      serial.port = "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_8e8b619b316cef1185ec99adc169b110-if00-port0";
      mqtt.server = "mqtt://127.0.0.1:1883";
      frontend.enable = true;
      serial.adapter = "ember";
      advanced.channel = 11;
      advanced.network_key = "74:cc:0e:52:6a:56:69:97:12:60:aa:b1:98:d0:6b:cf";
      advanced.pan_id = "5DA7";
      advanced.ext_pan_id = "bf:6e:50:0d:14:46:79:9b";
    };
  };
  services.mosquitto = {
    enable = config.services.zigbee2mqtt.enable;
    listeners = [
    {
      acl = [ "pattern readwrite #" ];
      omitPasswordAuth = true;
      settings.allow_anonymous = true;
    }
    ];
  };
}
