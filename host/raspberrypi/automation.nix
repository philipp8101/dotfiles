[
  {
    alias = "Nachtlicht Abends An";
    triggers = [ {
      trigger = "sun";
      event = "sunset";
      offset = "-00:30:00";
    } ];
    actions = [
      {
        action = "light.turn_on";
        target = {
          entity_id = "light.nachtlicht";
        };
      }
    ];
    mode = "single";
  }
  {
    alias = "Nachtlicht Abends Aus";
    triggers = [ {
      trigger = "time";
      at = "input_datetime.schlafen";
    } ];
    actions = [
      {
        action = "light.turn_off";
        target.entity_id = "light.nachtlicht";
      }
    ];
    mode = "single";
  }
  {
    alias = "wässern";
    description = "";
    conditions = [
      {
        condition = "state";
        entity_id = "input_boolean.bewaessern";
        state = "on";
      }
    ];
    triggers = [
      {
        trigger = "time";
        at = "input_datetime.bewasserungszeit";
      }
    ];
    actions = [
      {
        service = "switch.turn_on";
        entity_id = "switch.wasserventil";
      }
      {
        delay = {
          hours = 0;
          minutes = "{{ states(input_number.bewasserung_min) | float }}";
          seconds = 0;
          milliseconds = 0;
        };
      }
      {
        service = "switch.turn_off";
        entity_id = "switch.wasserventil";
      }
    ];
    mode = "single";
  }
  {
    alias = "Pumpe neustarten";
    description = "";
    triggers = [
      {
        trigger = "state";
        entity_id = [
          "sensor.wasserventil_current_device_status"
        ];
      }
    ];
    conditions = [
      {
        condition = "not";
        conditions = [
          {
            condition = "state";
            entity_id = "sensor.wasserventil_current_device_status";
            state = "normal_state";
          }
        ];
      }
      {
        condition = "state";
        entity_id = "input_boolean.bewaessern";
        state = "on";
      }
    ];
    actions = [
      {
        service = "switch.turn_off";
        entity_id = "switch.schalter_steckdose_3";
      }
      {
        delay = {
          hours = 0;
          minutes = 0;
          seconds = 15;
          milliseconds = 0;
        };
      }
      {
        service = "switch.turn_on";
        entity_id = "switch.schalter_steckdose_3";
      }
    ];
    mode = "single";
  }
  {
    alias = "Philipp Licht";
    description = "";
    triggers = [
      {
        trigger = "state";
        entity_id = "binary_sensor.bewegungsmelder_1_presence";
        from = "off";
        to = "on";
      }
    ];
    conditions = [
      {
        condition = "not";
        conditions = [
          {
            condition = "time";
            after = "input_datetime.schlafen";
            before = "input_datetime.aufstehen";
          }
        ];
      }
      {
        condition = "numeric_state";
        entity_id = "sensor.bewegungsmelder_1_illuminance";
        above = -1;
        below = 511;
      }
      {
        condition = "state";
        entity_id = "light.led_streifen";
        state = "off";
      }
      {
        condition = "state";
        entity_id = "input_boolean.bewegungsmelder_philipp";
        state = "on";
      }
    ];
    actions = [
      {
        action = "light.turn_on";
        target.entity_id = "light.led_streifen";
      }
      {
        alias = "Wait until there is no motion from device";
        wait_for_trigger = {
          trigger = "state";
          entity_id = "binary_sensor.bewegungsmelder_1_presence";
          from = "on";
          to = "off";
        };
      }
      {
        action = "light.turn_off";
        target.entity_id = "light.led_streifen";
      }
    ];
    mode = "restart";
    max_exceeded = "silent";
  }
  {
    alias = "Drehschalter 1 up";
    triggers = [ {
      domain = "mqtt";
      device_id = "ed3f2a0aa584eb0048bd870408f01429";
      # entity_id = "select.drehschalter_1_operation_mode";
      type = "action";
      subtype = "rotate_right";
      trigger = "device";
    } ];
    actions = [ {
      action = "light.turn_on";
      target.entity_id = "light.led_streifen";
      data.brightness_step_pct = 10;
      # data.brightness_step_pct = "{{ states('sensor.drehschalter_1_action_step_size') }}";
    } ];
    mode = "single";
  }
  {
    alias = "Drehschalter 1 down";
    triggers = [ {
      domain = "mqtt";
      device_id = "ed3f2a0aa584eb0048bd870408f01429";
      # entity_id = "select.drehschalter_1_operation_mode";
      type = "action";
      subtype = "rotate_left";
      trigger = "device";
    } ];
    actions = [ {
      action = "light.turn_on";
      target.entity_id = "light.led_streifen";
      data.brightness_step_pct = -10;
      # data.brightness_step_pct = "-{{ states('sensor.drehschalter_1_action_step_size') | float * 0.4 }}";
    } ];
    mode = "single";
  }
  {
    alias = "Drehschalter 1 toggle ";
    triggers = [ {
      domain = "mqtt";
      device_id = "ed3f2a0aa584eb0048bd870408f01429";
      # entity_id = "select.drehschalter_1_operation_mode";
      type = "action";
      subtype = "toggle";
      trigger = "device";
    } ];
    actions = [ {
      action = "light.toggle";
      target.entity_id = "light.led_streifen";
    } ];
    mode = "single";
  }
  {
    alias = "Drehschalter 2 up";
    triggers = [ {
      domain = "mqtt";
      device_id = "a6f624158cb7eff6e9f37a06f0ed24c2";
      # entity_id = "select.drehschalter_2_operation_mode";
      type = "action";
      subtype = "rotate_right";
      trigger = "device";
    } ];
    actions = [ {
      action = "light.turn_on";
      target.entity_id = "light.led_streifen_2";
      data.brightness_step_pct = 10;
      # data.brightness_step_pct = "{{ states('sensor.drehschalter_2_action_step_size') | float * 0.4 }}";
    } ];
    mode = "single";
  }
  {
    alias = "Drehschalter 2 down";
    triggers = [ {
      domain = "mqtt";
      device_id = "a6f624158cb7eff6e9f37a06f0ed24c2";
      # entity_id = "select.drehschalter_2_operation_mode";
      type = "action";
      subtype = "rotate_left";
      trigger = "device";
    } ];
    actions = [ {
      action = "light.turn_on";
      target.entity_id = "light.led_streifen_2";
      data.brightness_step_pct = -10;
      # data.brightness_step_pct = "-{{ states('sensor.drehschalter_2_action_step_size') | float * 0.4 }}";
    } ];
    mode = "single";
  }
  {
    alias = "Drehschalter 2 toggle ";
    triggers = [ {
      domain = "mqtt";
      device_id = "a6f624158cb7eff6e9f37a06f0ed24c2";
      # entity_id = "select.drehschalter_2_operation_mode";
      type = "action";
      subtype = "toggle";
      trigger = "device";
    } ];
    actions = [ {
      action = "light.toggle";
      target.entity_id = "light.led_streifen_2";
    } ];
    mode = "single";
  }
  {
    alias = "Nachtlicht Morgens An";
    triggers = [
      {
        trigger = "time";
        at = "input_datetime.aufstehen";
      }
    ];
    actions = [
      {
        action = "light.turn_on";
        target.entity_id = "light.nachtlicht";
      }
    ];
    mode = "single";
  }
  {
    alias = "Nachtlicht Morgens Aus";
    triggers = [
      {
        trigger = "sun";
        event = "sunrise";
        offset = "00:30:00";
      }
    ];
    actions = [
      {
        action = "light.turn_off";
        target.entity_id = "light.nachtlicht";
      }
    ];
    mode = "single";
  }
  {
    alias = "Bad Licht ";
    description = "";
    triggers = [
      {
        trigger = "state";
        entity_id = "binary_sensor.bad_bewegungsmelder_occupancy";
        from = "off";
        to = "on";
      }
    ];
    conditions = [
      {
        condition = "numeric_state";
        entity_id = "sensor.bad_bewegungsmelder_illuminance";
        above = -1;
        below = 511;
      }
      {
        condition = "state";
        entity_id = "light.bad_spiegel_licht";
        state = "off";
      }
    ];
    actions = [
      {
        alias = "Turn on the light";
        action = "light.turn_on";
        target.entity_id = "light.bad_spiegel_licht";
        data = {

        };
      }
      {
        alias = "Wait until there is no motion from device";
        wait_for_trigger = [
          {
            trigger = "state";
            entity_id = [
              "binary_sensor.bad_bewegungsmelder_occupancy"
            ];
            from = "on";
            to = "off";
          }
        ];
      }
      {
        action = "light.turn_off";
        target.entity_id = "light.bad_spiegel_licht";
      }
    ];
    mode = "single";
    max_exceeded = "silent";
  }
]
