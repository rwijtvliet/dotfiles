// CONTROLLING LEDS.

// extern rgb_config_t rgb_matrix_config;

const uint8_t PROGMEM ledmap[][NUMBER_OF_LEDS] = {
    [L_BASE] = {PREP_LIGHTS(LIGHTS_BASE)},
    [L_BASE2] = {PREP_LIGHTS(LIGHTS_BASE2)},
    [L_SYM] = {PREP_LIGHTS(LIGHTS_SYM)},
    [L_NUM] = {PREP_LIGHTS(LIGHTS_NUM)},
    [L_NAV] = {PREP_LIGHTS(LIGHTS_NAV)},
    [L_WEBNAV] = {PREP_LIGHTS(LIGHTS_WEBNAV)},
    [L_FUN] = {PREP_LIGHTS(LIGHTS_FUN)},
    [L_MOUSE] = {PREP_LIGHTS(LIGHTS_MOUSE)},
    [L_SYSTEM] = {PREP_LIGHTS(LIGHTS_SYSTEM)},
    [L_GAME] = {PREP_LIGHTS(LIGHTS_GAME)},
};

bool get_ledmap_color(uint8_t layer, int i, rgb_led_t *rgb) {
  if (NUMBER_OF_LEDS == 0) {
    return false;
  }
  uint8_t hue = pgm_read_byte(&ledmap[layer][i]);
  HSV hsv;
  switch (hue) {
  case _____:
    if (layer == 0) {
      return false; // leave off; no layer below.
    }
    return get_ledmap_color(layer - 1, i, rgb);

  case WHITE:
    hsv = (HSV){0, 0, hsv_value};
    break;

  case GRAY:
    hsv = (HSV){0, 0, hsv_value / 2};
    break;

  case XXXXX:
    return false; // leave off

  default:
    hsv = (HSV){hue, hsv_saturation, hsv_value};
  };
  *rgb = hsv_to_rgb(hsv);
  return true;
}

void set_layer_color(int layer) {
  if (NUMBER_OF_LEDS == 0) {
    return;
  }
  rgb_led_t rgb;
  for (int i = 0; i < NUMBER_OF_LEDS; i++) {
    if (!get_ledmap_color(layer, i, &rgb)) {
      rgb = (rgb_led_t){.r = 0, .g = 0, .b = 0};
    }
    rgb_matrix_set_color(i, rgb.r, rgb.g, rgb.b);
  }
}

bool rgb_matrix_indicators_user(void) {
  // if (g_suspend_state || keyboard_config.disable_layer_led) { return; }
  if (NUMBER_OF_LEDS == 0) {
    return false;
  }
  uint8_t bitval = biton32(layer_state);
  if (bitval <= 8) {
    set_layer_color(bitval);
  } else if (rgb_matrix_get_flags() == LED_FLAG_NONE) {
    rgb_matrix_set_color_all(0, 0, 0);
  }
  return true;
}
