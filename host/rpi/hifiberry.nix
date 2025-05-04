{ pkgs, config, ... }: let
  hifiberry-dts = builtins.fetchurl {
    url = "https://github.com/raspberrypi/linux/raw/refs/heads/rpi-6.1.y/arch/arm/boot/dts/overlays/hifiberry-dacplus-overlay.dts";
    sha256 = "sha256:1lhcg86anx4bqpxvkc9aznfvlqgmzajv7madwknlnplw13s7l5jl";
  };
in {
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
      	    [audio]
      	    output = pulsesink server=127.0.0.1
      	'';
    extensionPackages = with pkgs; [
      mopidy-jellyfin
    ];
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  hardware.pulseaudio.tcp = {
    enable = true;
    anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
  };
  
  boot.kernelPackages = pkgs.linuxPackages_rpi3;

  hardware.i2c.enable = true;
  hardware.deviceTree.enable = true;
  hardware.deviceTree = {
    filter = "bcm*-rpi-3-b.dtb";
    # Equivalent to: https://github.com/raspberrypi/linux/blob/fbd8b3facb36ce888b1cdcf5f45a78475a8208f2/arch/arm/boot/dts/overlays/hifiberry-dac-overlay.dts
    overlays = [
      "${config.boot.kernelPackages.kernel}/dtbs/overlays/hifiberry-dac.dtbo"
    ];
  };

  # # https://blog.suddaby.net/post/nixos-hifiberry-dac-light/
  # hardware = {
  #   # doesnt exist for pi 3, dont know if we need it
  #   # raspberry-pi."4".apply-overlays-dtmerge.enable = true;
  #   deviceTree = {
  #     enable = true;
  #     filter = "bcm2711-rpi-3*.dtb";
  #     overlays = [
  #       {
  #         name = "hifiberry-dac";
  #         dtsText = builtins.readFile hifiberry-dts;
  #       }
  #     ];
  #   };
  # };
}
