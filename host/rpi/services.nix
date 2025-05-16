{ pkgs, ... }:
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
  networking.firewall.allowedTCPPorts = [ 8123 ];
}
