{ pkgs, config, ... }:
{
  boot.blacklistedKernelModules = [
    # "snd_bcm2835"
    # "snd_soc_pcm5102a"
    # "i2c_dev"
    # "snd_soc_rpi_simple_soundcard"
  ];
  
  boot.kernelPackages = pkgs.linuxPackages_rpi3;

  boot.kernelModules = [
    "regmap-i2c"
    "i2c-bcm2835"
    # "snd-soc-bcm2708"
    "snd-soc-pcm512x"
    "snd-soc-pcm512x-i2c"
    # "clk-hifiberry-dacpro"
    "snd-soc-hifiberry-dacplus"
    "bcm2835-v4l2"
    "vc4"
    "drm_kms_helper"
  ];
  # boot.kernelPatches = [
  #   {
  #     name = "snd-soc-pcm";
  #     patch = null;
  #     extraConfig = ''
  #       CONFIG_SND_SOC_PCM512x_I2C m
  #       CONFIG_SND_SOC_PCM512x m
  #       CONFIG_DYNAMIC_DEBUG y
  #       CONFIG_DEBUG_FS y
  #     '';
  #   }
  # ];

  hardware.i2c.enable = true;
  hardware.deviceTree.enable = true;
  hardware.deviceTree = {
    overlays = [
      {
        name = "hifiberry-dacplus";
        filter = "bcm*-rpi-3-b*";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/hifiberry-dacplus.dtbo";
      }
      {
        name = "hifiberry-dacplus-std";
        filter = "bcm*-rpi-3-b*";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/hifiberry-dacplus-std.dtbo";
      }
      # {
      #   name = "audio";
      #   filter = "bcm*-rpi-3-b*";
      #   dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/vc4-kms-v3d.dtbo";
      # }
      # {
      #   name = "audio";
      #   filter = "bcm*-rpi-3-b*";
      #   dtsText = ''
      #   /dts-v1/;
      #   /plugin/;
      #   
      #   / {
      #     compatible = "brcm,bcm2835";
      #     
      #     fragment@0 {
      #       target = <&i2s>;
      #       __overlay__ {
      #         status = "okay";
      #       };
      #     };
      #     
      #     fragment@1 {
      #       target-path = "/";
      #       __overlay__ {
      #         pcm5102a-codec {
      #           #sound-dai-cells = <0>;
      #           compatible = "ti,pcm5102a";
      #           status = "okay";
      #         };
      #       };
      #     };
      #     
      #     fragment@2 {
      #       target = <&sound>;
      #       __overlay__ {
      #         compatible = "hifiberry,hifiberry-dac";
      #         i2s-controller = <&i2s>;
      #         status = "okay";
      #       };
      #     };
      #   };
      #   '';
      # }
      {
        name = "i2c0";
        filter = "*rpi*";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/i2c0.dtbo";
      }
      {
        name = "i2c1";
        filter = "*rpi*";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/i2c1.dtbo";
      }
      {
        name = "i2cgpio";
        filter = "*rpi*";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/i2c-gpio.dtbo";
      }
    ];
  };
  # systemd.services = {
  #   "hifiberry-dac-overlay" = {
  #     serviceConfig = {
  #       Type = "oneshot";
  #     };
  #     wantedBy = ["multi-user.target"];
  #     script = ''
  #       ${pkgs.libraspberrypi}/bin/dtoverlay -d ${config.boot.kernelPackages.kernel}/dtbs/overlays/ hifiberry-dac || echo "already in use"
  #     '';
  #   };
  # };

}
