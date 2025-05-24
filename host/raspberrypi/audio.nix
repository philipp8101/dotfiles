{
  # https://wiki.nixos.org/wiki/PipeWire
  # Socket activation too slow for headless; start at boot instead.
  services.pipewire.socketActivation = false; 
  # Start WirePlumber (with PipeWire) at boot.
  systemd.user.services.wireplumber.wantedBy = [ "default.target" ];
}
