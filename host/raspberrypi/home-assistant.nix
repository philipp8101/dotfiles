{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
      "homeassistant_hardware"
      "tuya"
      "mobile_app"
      "history"
    ];
    extraPackages = ps: with ps; [
      getmac
      gtts
      paho-mqtt
      pyturbojpeg
      isal
      zlib-ng
    ];
    config = {
      default_config = {};
      automation = (import ./automation.nix);
      mobile_app = "";
      input_boolean.bewaessern = {
        name = "Bewässern";
        icon = "mdi:watering-can";
      };
    };
  };
}
