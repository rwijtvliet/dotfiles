// 2022 2023 Ruud Wijtvliet (@rwijtvliet)
//
// good tutorial:
// https://precondition.github.io/home-row-mods

// clang-format off

// Take the partial keymap, and assign standard functions to the keys on the keyboard that are extra (i.e., not used by the partial keymap).
#define PREP_LAYER_FOR_VOYAGER(\
               _ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
               _ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
               _ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,_CENTRL1  ,_CENTRR1  ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
               _CORNERL  ,                      _THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1  ,                      _CORNERR  ) \
               \
    XXXXXXX   ,KC_1      ,KC_2      ,KC_3      ,KC_4      ,KC_5      ,                      KC_6      ,KC_7      ,KC_8      ,KC_9      ,KC_0      ,XXXXXXX   ,\
    XXXXXXX   ,_ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,XXXXXXX   ,\
    _CORNERL  ,_ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,_CORNERR  ,\
    _CORNERL  ,_ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,                      _ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,_CORNERR  ,\
                                                _THUMBL1  ,_THUMBL2  ,                      _THUMBR2  ,_THUMBR1

// voyager expects lights to be: left side, then right side. 
#define PREP_LIGHTS_FOR_VOYAGER(\
               _ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
               _ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
               _ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,_CENTRL1  ,_CENTRR1  ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
               _CORNERL  ,                      _THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1  ,                      _CORNERR  ) \
               \
    XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,\
    XXXXX     ,_ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,\
    _CORNERL  ,_ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,\
    _CORNERL  ,_ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,\
                                                _THUMBL1  ,_THUMBL2  ,\
                                                                                             XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,\  
                                                                                             _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,XXXXX     ,\
                                                                                             _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,_CORNERR  ,\
                                                                                             _ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,_CORNERR  ,\ 
                                                                                             _THUMBR2  ,_THUMBR1

// clang-format on

#define PREP_LAYER(...) PREP_LAYER_FOR_VOYAGER(__VA_ARGS__)
#define PREP_LIGHTS(...) PREP_LIGHTS_FOR_VOYAGER(__VA_ARGS__)
#define EXPAND_LAYOUT(x) LAYOUT_voyager(x)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [L_BASE] = EXPAND_LAYOUT(PREP_LAYER(LAYER_BASE)),
    [L_BASE2] = EXPAND_LAYOUT(PREP_LAYER(LAYER_BASE2)),
    [L_SYM] = EXPAND_LAYOUT(PREP_LAYER(LAYER_SYM)),
    [L_NUM] = EXPAND_LAYOUT(PREP_LAYER(LAYER_NUM)),
    [L_NAV] = EXPAND_LAYOUT(PREP_LAYER(LAYER_NAV)),
    [L_WEBNAV] = EXPAND_LAYOUT(PREP_LAYER(LAYER_WEBNAV)),
    [L_FUN] = EXPAND_LAYOUT(PREP_LAYER(LAYER_FUN)),
    [L_MOUSE] = EXPAND_LAYOUT(PREP_LAYER(LAYER_MOUSE)),
    [L_SYSTEM] = EXPAND_LAYOUT(PREP_LAYER(LAYER_SYSTEM)),
    [L_GAME] = EXPAND_LAYOUT(PREP_LAYER(LAYER_GAME)),
};

extern rgb_config_t rgb_matrix_config;

const uint8_t PROGMEM ledmap[][DRIVER_LED_TOTAL] = {
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
  if (layer < 0) {
    return false;
  }
  uint8_t hue = ledmap[layer][i];
  HSV hsv;
  switch (hue) {
  case _____:
    return get_ledmap_color(layer - 1, i, rgb);

  case WHITE:
    hsv = (HSV){0, 0, hsv_value};
    break;

  case GRAY:
    hsv = (HSV){0, 0, hsv_value / 2};
    break;

  case XXXXX:
    hsv = (HSV){0, 0, 0};
    break;

  default:
    hsv = (HSV){hue, hsv_saturation, hsv_value};
  };
  *rgb = hsv_to_rgb(hsv);
  return true;
}

void set_layer_color(int layer) {
  rgb_led_t rgb;
  for (int i = 0; i < RGB_MATRIX_LED_COUNT; i++) {
    if (get_ledmap_color(layer, i, &rgb)) {
      rgb_matrix_set_color(i, rgb.r, rgb.g, rgb.b);
    }
  }
}

bool rgb_matrix_indicators_user(void) {
  // if (g_suspend_state || keyboard_config.disable_layer_led) { return; }
  uint8_t bitval = biton32(layer_state);
  if (bitval <= 8) {
    set_layer_color(bitval);
  } else if (rgb_matrix_get_flags() == LED_FLAG_NONE) {
    rgb_matrix_set_color_all(0, 0, 0);
  }
  return true;
}

// Required by keymap_partail.c
void custom_led_indicators(enum supported_os os) {
  ergodox_board_led_off();
  ergodox_right_led_1_off();
  ergodox_right_led_2_off();
  ergodox_right_led_3_off();
  if (os == LINUX) {
    ergodox_right_led_1_on();
  } else if (os == WINDOWS) {
    ergodox_right_led_2_on();
  } else { // MACOS
    ergodox_right_led_3_on();
  }
}
void custom_post_init(void) { rgb_matrix_enable(); }
