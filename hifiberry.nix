{config, lib, pkgs, user, ...}:{
    hardware.pulseaudio.enable = true;
    services.mopidy = {
	enable = true;
	configuration = ''
	    [jellyfin]
	    hostname = http://localhost:8096
	    username = jellyfin
	    password = 123
	    libraries = Music
	    max_bitrate = 48000
	'';
	extensionPackages = with pkgs; [
	    mopidy-jellyfin
	];
    };
    services.jellyfin.enable = true;
}
