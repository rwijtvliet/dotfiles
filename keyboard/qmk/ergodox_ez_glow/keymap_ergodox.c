// 2022 2023 Ruud Wijtvliet (@rwijtvliet)

// clang-format off

// Take the partial keymap, and assign standard functions to the keys on the keyboard that are extra (i.e., not used by the partial keymap).
#define PREP_LAYER_FOR_ERGODOX(\
               _ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
               _ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
               _ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,_CENTRL1  ,_CENTRR1  ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
               _CORNERL  ,                      _THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1  ,                      _CORNERR  ) \
               \
    KC_ESC    ,KC_1      ,KC_2      ,KC_3      ,KC_4      ,KC_5      ,KC_CAPS   ,KC_INS    ,KC_6      ,KC_7      ,KC_8      ,KC_9      ,KC_0      ,pGAME     ,\
    XXXXXXX   ,_ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,KC_TAB    ,KC_MPLY   ,_ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,XXXXXXX   ,\
    _CORNERL  ,_ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,_CORNERR  ,\
    _CORNERL  ,_ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,KC_MPRV   ,KC_MNXT   ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,_CORNERR  ,\
    _CORNERL  ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,                                            XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,_CORNERR  ,\
                                                           _CENTRL1  ,_CENTRR1  ,_CENTRL1  ,_CENTRR1  ,                                                       \
                                                                      _CENTRL2  ,_CENTRR2  ,                                                                  \
                                                _THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1

// ergodox expects lights to be: right side, as-is, then left side, but mirrored.
#define PREP_LIGHTS_FOR_ERGODOX(\
               _ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
               _ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
               _ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,_CENTRL1  ,_CENTRR1  ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
               _CORNERL  ,                      _THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1  ,                      _CORNERR  ) \
               \
                                                                                            XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,\
                                                                                            _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
                                                                                            _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
                                                                                            _ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
                                                                                                       XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,\
                XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,XXXXX     ,\
                _ALPHA05  ,_ALPHA04  ,_ALPHA03  ,_ALPHA02  ,_ALPHA01  ,\
                _ALPHA15  ,_ALPHA14  ,_ALPHA13  ,_ALPHA12  ,_ALPHA11  ,\
                _ALPHA25  ,_ALPHA24  ,_ALPHA23  ,_ALPHA22  ,_ALPHA21  ,\
                           XXXXX     ,XXXXX     ,XXXXX     ,XXXXX    

// clang-format on

#define PREP_LAYER(...) PREP_LAYER_FOR_ERGODOX(__VA_ARGS__)
#define EXPAND_LAYOUT(x) LAYOUT_ergodox_pretty(x)

// Required by keymap_common.c

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

// Required by keymap_lights.c

#define PREP_LIGHTS(...) PREP_LIGHTS_FOR_ERGODOX(__VA_ARGS__)
#define NUMBER_OF_LEDS RGB_MATRIX_LED_COUNT

void set_layer_color(int);

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
