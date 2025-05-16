{
  # https://wiki.nixos.org/wiki/PipeWire
  # Socket activation too slow for headless; start at boot instead.
  services.pipewire.socketActivation = false; 
  # Start WirePlumber (with PipeWire) at boot.
  systemd.user.services.wireplumber.wantedBy = [ "default.target" ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  # services.pulseaudio = {
  #   enable = true;
  #   # systemWide = true;  # Try system-wide mode
  #   support32Bit = true;  # For compatibility
  #   package = pkgs.pulseaudioFull;  # Full package with all modules
  #   extraConfig = ''
  #     load-module module-alsa-card device_id=2 name=hifiberry_dac
  #   '';
  #   tcp = {
  #     enable = true;
  #     anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
  #   };
  # };
}
