{
  version = 4;
  mqtt = {
    base_topic = "zigbee2mqtt";
    server = "mqtt://127.0.0.1:1883";
    user = "philipp";
    password = "123";
  };
  serial = {
    port = "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_8e8b619b316cef1185ec99adc169b110-if00-port0";
    adapter = "zstack";
    baudrate = 115200;
    rtscts = false;
  };
  advanced = {
    log_level = "info";
    channel = 11;
    network_key = [
      115
      58
      0
      132
      193
      94
      16
      107
      209
      92
      206
      78
      244
      48
      68
      0
    ];
    pan_id = 48142;
    ext_pan_id = [
      46
      193
      90
      225
      29
      27
      91
      153
    ];
  };
  frontend = {
    enabled = true;
    port = 8099;
  };
  homeassistant = {
    enabled = true;
  };
  devices = {
    "0xa4c138a3d33a19e9" = {
      friendly_name = "LED Streifen";
    };
    "0xa4c138cf28a8e9b1" = {
      friendly_name = "Schalter Steckdose 1";
    };
    "0xa4c138d0acd203ac" = {
      friendly_name = "Schalter Steckdose 2";
    };
    "0xa4c138da67978940" = {
      friendly_name = "Schalter Steckdose 3";
    };
    "0xa4c1383f008fac56" = {
      friendly_name = "Schalter Steckdose 4";
    };
    "0x187a3efffe38af67" = {
      friendly_name = "Wasserventil";
    };
    "0xa4c13801d9d0242b" = {
      friendly_name = "Terrassenlicht";
    };
    "0xa4c1385e97be65a5" = {
      friendly_name = "LED Streifen 2";
    };
    "0xa4c1382240539268" = {
      friendly_name = "Bewegungsmelder 1";
    };
    "0xa4c138e166899dba" = {
      friendly_name = "Drehschalter 1";
    };
    "0xa4c138f4d1738d88" = {
      friendly_name = "Drehschalter 2";
    };
    "0xa4c1389b0b9c5321" = {
      friendly_name = "0xa4c1389b0b9c5321";
    };
    "0xa4c138b2797d59c8" = {
      friendly_name = "Bad Spiegel Licht";
    };
    "0xa4c138f0104737fc" = {
      friendly_name = "Bad Bewegungsmelder";
    };
  };
}
