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
}
