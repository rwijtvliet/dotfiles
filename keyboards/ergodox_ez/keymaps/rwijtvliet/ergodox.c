// Copyright 2022 Ruud Wijtvliet (@rwijtvliet)
//
// SPDX-License-Identifier: GPL-2.0-or-later
//
// good tutorial:
// https://precondition.github.io/home-row-mods

// #include "version.h"
// #include "keymap_german.h"
// #include "keymap_nordic.h"
// #include "keymap_french.h"
// #include "keymap_spanish.h"
// #include "keymap_hungarian.h"
// #include "keymap_swedish.h"
// #include "keymap_br_abnt2.h"
// #include "keymap_canadian_multilingual.h"
// #include "keymap_german_ch.h"
// #include "keymap_jp.h"
// #include "keymap_korean.h"
// #include "keymap_bepo.h"
// #include "keymap_italian.h"
// #include "keymap_slovenian.h"
// #include "keymap_lithuanian_azerty.h"
// #include "keymap_danish.h"
// // #include "keymap_norwegian.h"
// #include "keymap_portuguese.h"
// // #include "keymap_contributions.h"
// #include "keymap_czech.h"
// #include "keymap_romanian.h"
// #include "keymap_russian.h"
// #include "keymap_uk.h"
// #include "keymap_estonian.h"
// #include "keymap_belgian.h"
// #include "keymap_us_international.h"
// #include "keymap_croatian.h"
// #include "keymap_turkish_q.h"
// #include "keymap_slovak.h"

#undef lGAME
#define lGAME    XXXXXXX //disable game layer; too much memory


#define PREP_FOR_ERGODOX_IN(\
               _0L4      ,_0L3      ,_0L2      ,_0L1      ,_0L0      ,                      _0R0      ,_0R1      ,_0R2      ,_0R3      ,_0R4      ,\
               _1L4      ,_1L3      ,_1L2      ,_1L1      ,_1L0      ,                      _1R0      ,_1R1      ,_1R2      ,_1R3      ,_1R4      ,\
               _2L4      ,_2L3      ,_2L2      ,_2L1      ,_2L0      ,_2LI      ,_2RI      ,_2R0      ,_2R1      ,_2R2      ,_2R3      ,_2R4      ,\
               _3L4      ,_3L3      ,_3L2      ,_3L1      ,_3L0      ,_3LI      ,_3RI      ,_3R0      ,_3R1      ,_3R2      ,_3R3      ,_3R4      ) \
               \
    KC_ESC    ,KC_1      ,KC_2      ,KC_3      ,KC_4      ,KC_5      ,KC_CAPS   ,KC_INS    ,KC_6      ,KC_7      ,KC_8      ,KC_9      ,KC_0      ,lGAME     ,\
    fCOPY     ,_0L4      ,_0L3      ,_0L2      ,_0L1      ,_0L0      ,KC_TAB    ,KC_MPLY   ,_0R0      ,_0R1      ,_0R2      ,_0R3      ,_0R4      ,fCOPY     ,\
    fPASTE    ,_1L4      ,_1L3      ,_1L2      ,_1L1      ,_1L0      ,                      _1R0      ,_1R1      ,_1R2      ,_1R3      ,_1R4      ,fPASTE    ,\
    fCUT      ,_2L4      ,_2L3      ,_2L2      ,_2L1      ,_2L0      ,KC_MPRV   ,KC_MNXT   ,_2R0      ,_2R1      ,_2R2      ,_2R3      ,_2R4      ,fCUT      ,\
    KC_ESC    ,_3L4      ,_3L3      ,_3L2      ,_3L1      ,                                            _3R1      ,_3R2      ,_3R3      ,_3R4      ,KC_ENT    ,\
                                                           _2LI      ,_2RI      ,_2LI      ,_2RI      ,                                                       \
                                                                      KC_APP    ,KC_APP    ,                                                                  \
                                                _3L0      ,_3LI      ,XXXXXXX   ,XXXXXXX   ,_3RI      ,_3R0


#define PREP_FOR_ERGODOX(...)  PREP_FOR_ERGODOX_IN(__VA_ARGS__)
#define EXPAND_LAYOUT(x) LAYOUT_ergodox_pretty(x)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[L_BASE] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_BASE)),
[L_BASE2] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_BASE2)),
[L_SYM] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_SYM)),
[L_NUM] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_NUM)),
[L_NAV] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_NAV)),
[L_NAV2] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_NAV2)),
[L_FUN] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_FUN)),
[L_FUN2] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_FUN2)),
[L_MOUSE] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_MOUSE)),
// [L_GAME] = EXPAND_LAYOUT(PREP_FOR_ERGODOX(LAYER_GAME)),
};


// --------------------------------- additional thingks for the lights ---------------------------------------------

enum custom_keycodes {
  RGB_SLD = EZ_SAFE_RANGE,
};

// extern bool g_suspend_state;
extern rgb_config_t rgb_matrix_config;

void keyboard_post_init_user(void) {
  rgb_matrix_enable();
}

// colors: 5 characters
#define _____ {0,0,0}
#define l_bas {0,0,128}
#define l_fun {14,255,255}
#define l_sym {33,255,255}
#define l_mou {0,205,155}
#define l_nav {154,255,255}
#define l_num {141,255,233}

#define modif {0,0,255}
#define tabul {0,0,255}

#define brckt {0,245,245}
#define numbr {141,255,233}
#define arith {41,255,255}
#define symbl {219,255,255}
#define coppa {70,220,255} //copy-paste
#define nav_2 {121,225,255}
#define nav_1 {152,255,255}
#define delet {0,255,255}
#define fun_1 {14,128,255}
#define fun_2 {10,225,255}
#define mou_1 {220,220,255}
#define mou_2 {188,255,255}


const uint8_t PROGMEM ledmap[][DRIVER_LED_TOTAL][3] = {
    [L_BASE] = {                                    //right side
                                                    _____, _____, _____, _____, _____, \
                                                    _____, l_fun, l_sym, _____, _____, \
                                                    _____, modif, modif, modif, modif, \
                                                    _____, l_mou, _____, _____, _____, \
                                                           tabul, _____, _____, tabul, \
                // left side, but mirrored
                _____, _____, _____, _____, _____, \
                l_fun, l_num, l_sym, _____, _____, \
                l_fun, modif, modif, modif, modif, \
                _____, l_mou, _____, _____, _____, \
                       l_nav, l_nav, _____, tabul },

    [L_BASE2] = {                                   _____, _____, _____, _____, _____, \
                                                    _____, _____, _____, _____, _____, \
                                                    _____, _____, _____, _____, _____, \
                                                    _____, _____, _____, _____, _____, \
                                                           _____, _____, _____, _____, \
                _____, _____, _____, _____, _____, \
                _____, _____, _____, _____, _____, \
                _____, _____, _____, _____, _____, \
                _____, _____, _____, _____, _____, \
                       _____, _____, _____, _____ },

    [L_SYM] = {                                     _____, _____, _____, _____, _____, \
                                                    symbl, brckt, brckt, symbl, arith, \
                                                    arith, brckt, brckt, arith, symbl, \
                                                    arith, brckt, brckt, symbl, arith, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                arith, symbl, symbl, symbl, symbl, \
                _____, modif, modif, modif, modif, \
                _____, symbl, symbl, symbl, symbl, \
                       _____, _____, _____, tabul },

    [L_NUM] = {                                     _____, _____, _____, _____, _____, \
                                                    numbr, numbr, numbr, numbr, arith, \
                                                    arith, numbr, numbr, numbr, symbl, \
                                                    arith, numbr, numbr, numbr, arith, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                _____, _____, _____, _____, _____, \
                _____, modif, modif, modif, modif, \
                _____, _____, _____, numbr, numbr, \
                       l_bas, _____, _____, tabul },

    [L_NAV] = {                                     _____, _____, _____, _____, _____, \
                                                    coppa, nav_2, nav_2, nav_2, nav_2, \
                                                    coppa, nav_1, nav_1, nav_1, nav_1, \
                                                    coppa, delet, modif, modif, modif, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                coppa, nav_2, nav_2, nav_2, nav_2, \
                coppa, modif, modif, modif, modif, \
                coppa, delet, _____, mou_2, mou_2, \
                       l_bas, _____, _____, tabul },

    [L_NAV2] = {                                    _____, _____, _____, _____, _____, \
                                                    coppa, nav_2, nav_2, nav_2, nav_2, \
                                                    coppa, nav_1, nav_1, nav_1, nav_1, \
                                                    coppa, delet, modif, modif, modif, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                coppa, nav_2, nav_2, nav_2, nav_2, \
                coppa, modif, modif, modif, modif, \
                coppa, delet, modif, symbl, symbl, \
                       l_bas, _____, _____, tabul },

    [L_FUN] = {                                     _____, _____, _____, _____, _____, \
                                                    _____, _____, modif, _____, _____, \
                                                    _____, _____, modif, modif, _____, \
                                                    _____, _____, _____, _____, _____, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                _____, fun_1, fun_1, fun_1, fun_1, \
                _____, fun_1, fun_1, fun_1, fun_1, \
                _____, fun_1, fun_1, fun_1, fun_1, \
                       _____, _____, _____, tabul },

    [L_FUN2] = {                                    _____, _____, _____, _____, _____, \
                                                    _____, _____, _____, _____, _____, \
                                                    _____, _____, modif, modif, _____, \
                                                    _____, _____, _____, _____, _____, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                _____, fun_2, fun_2, fun_2, fun_2, \
                _____, fun_2, fun_2, fun_2, fun_2, \
                _____, fun_2, fun_2, fun_2, fun_2, \
                       _____, _____, _____, tabul },

    [L_MOUSE] = {                                   _____, _____, _____, _____, _____, \
                                                    _____, mou_2, mou_1, mou_2, _____, \
                                                    _____, mou_1, mou_1, mou_1, _____, \
                                                    _____, _____, mou_2, mou_2, mou_2, \
                                                           tabul, _____, _____, tabul, \
                _____, _____, _____, _____, _____, \
                _____, mou_2, mou_1, mou_2, _____, \
                _____, mou_1, mou_1, mou_1, _____, \
                _____, _____, mou_2, mou_2, mou_2, \
                       _____, _____, _____, tabul },

    // [L_GAME] = { _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, _____, modif, _____, _____, modif, modif, modif, _____, _____, _____, _____, _____, _____, _____, _____, _____, modif, _____, _____, _____, modif, modif, modif, _____, _____, _____, _____, _____, _____, _____, _____, _____ },

};


void set_layer_color(int layer) {

  for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
    HSV hsv = {
      .h = pgm_read_byte(&ledmap[layer][i][0]),
      .s = pgm_read_byte(&ledmap[layer][i][1]),
      .v = pgm_read_byte(&ledmap[layer][i][2]),
    };
    if (!hsv.h && !hsv.s && !hsv.v) {
        rgb_matrix_set_color( i, 0, 0, 0 );
    } else {
        RGB rgb = hsv_to_rgb( hsv );
        float f = (float)rgb_matrix_config.hsv.v / UINT8_MAX;
        rgb_matrix_set_color( i, f * rgb.r, f * rgb.g, f * rgb.b );
    }
  }
}


// void rgb_matrix_indicators_user(void) {
// //   if (g_suspend_state || keyboard_config.disable_layer_led) { return; }
//   switch (biton32(layer_state)) {
//     case 0:
//       set_layer_color(0);
//       break;
//     case 1:
//       set_layer_color(1);
//       break;
//     case 2:
//       set_layer_color(2);
//       break;
//     case 3:
//       set_layer_color(3);
//       break;
//     case 4:
//       set_layer_color(4);
//       break;
//     case 5:
//       set_layer_color(5);
//       break;
//     case 6:
//       set_layer_color(6);
//       break;
//     case 7:
//       set_layer_color(7);
//       break;
//     case 8:
//       set_layer_color(8);
//       break;
//    default:
//     if (rgb_matrix_get_flags() == LED_FLAG_NONE)
//       rgb_matrix_set_color_all(0, 0, 0);
//     break;
//   }
// }
void rgb_matrix_indicators_user(void) {
  //if (g_suspend_state || keyboard_config.disable_layer_led) { return; }
  uint8_t bitval = biton32(layer_state);
  if (bitval <= 8) {
      set_layer_color(bitval);
  } else if (rgb_matrix_get_flags() == LED_FLAG_NONE) {
      rgb_matrix_set_color_all(0, 0, 0);
  }
}

// uint32_t layer_state_set_user(uint32_t state) {
//   ergodox_board_led_off();
//   ergodox_right_led_1_off();
//   ergodox_right_led_2_off();
//   ergodox_right_led_3_off();
//   return state;
// };
