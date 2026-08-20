{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire."10-clock-rate"."context.properties" = {
      "default.clock.rate" = 192000;
      "default.clock.allowed-rate" = [ 41000 48000 88200 96000 192000 ];
    };
  };
}
