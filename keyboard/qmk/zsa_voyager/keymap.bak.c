#include QMK_KEYBOARD_H
#include "keymap_belgian.h"
#include "keymap_bepo.h"
#include "keymap_br_abnt2.h"
#include "keymap_canadian_multilingual.h"
#include "keymap_contributions.h"
#include "keymap_croatian.h"
#include "keymap_czech.h"
#include "keymap_danish.h"
#include "keymap_estonian.h"
#include "keymap_french.h"
#include "keymap_german.h"
#include "keymap_german_ch.h"
#include "keymap_hungarian.h"
#include "keymap_italian.h"
#include "keymap_jp.h"
#include "keymap_korean.h"
#include "keymap_lithuanian_azerty.h"
#include "keymap_nordic.h"
#include "keymap_norwegian.h"
#include "keymap_portuguese.h"
#include "keymap_romanian.h"
#include "keymap_russian.h"
#include "keymap_slovak.h"
#include "keymap_slovenian.h"
#include "keymap_spanish.h"
#include "keymap_swedish.h"
#include "keymap_turkish_q.h"
#include "keymap_uk.h"
#include "keymap_us_international.h"
#include "version.h"

#define KC_MAC_UNDO LGUI(KC_Z)
#define KC_MAC_CUT LGUI(KC_X)
#define KC_MAC_COPY LGUI(KC_C)
#define KC_MAC_PASTE LGUI(KC_V)
#define KC_PC_UNDO LCTL(KC_Z)
#define KC_PC_CUT LCTL(KC_X)
#define KC_PC_COPY LCTL(KC_C)
#define KC_PC_PASTE LCTL(KC_V)
#define ES_LESS_MAC KC_GRAVE
#define ES_GRTR_MAC LSFT(KC_GRAVE)
#define ES_BSLS_MAC ALGR(KC_6)
#define NO_PIPE_ALT KC_GRAVE
#define NO_BSLS_ALT KC_EQUAL
#define LSA_T(kc) MT(MOD_LSFT | MOD_LALT, kc)
#define BP_NDSH_MAC ALGR(KC_8)
#define SE_SECT_MAC ALGR(KC_6)
#define MOON_LED_LEVEL LED_LEVEL

enum custom_keycodes {
  RGB_SLD = ML_SAFE_RANGE,
  HSV_0_255_255,
  HSV_74_255_255,
  HSV_169_255_255,
};

enum tap_dance_codes {
  DANCE_0,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_voyager(
        TD(DANCE_0), KC_1, KC_2, KC_3, KC_4, KC_5, KC_6, KC_7, KC_8, KC_9, KC_0,
        KC_MINUS, CAPS_WORD, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I,
        KC_O, KC_P, KC_BSLASH, MT(MOD_LSFT, KC_BSPACE), KC_A, KC_S, KC_D, KC_F,
        KC_G, KC_H, KC_J, KC_K, KC_L, KC_SCOLON, MT(MOD_RSFT, KC_QUOTE),
        KC_LGUI, MT(MOD_LALT, KC_Z), KC_X, KC_C, KC_V, KC_B, KC_N, KC_M,
        KC_COMMA, KC_DOT, MT(MOD_RALT, KC_SLASH), KC_RCTRL, LT(1, KC_ENTER),
        MT(MOD_LCTL, KC_TAB), MT(MOD_LSFT, KC_BSPACE), LT(2, KC_SPACE)),
    [1] = LAYOUT_voyager(
        KC_ESCAPE, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F6, KC_F7, KC_F8,
        KC_F9, KC_F10, KC_F11, KC_GRAVE, KC_EXLM, KC_AT, KC_HASH, KC_DLR,
        KC_PERC, KC_7, KC_8, KC_9, KC_MINUS, KC_SLASH, KC_F12, KC_TRANSPARENT,
        KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_4, KC_5, KC_6, KC_PLUS,
        KC_ASTR, KC_BSPACE, KC_TRANSPARENT, KC_TRANSPARENT, KC_LBRACKET,
        KC_RBRACKET, KC_LCBR, KC_RCBR, KC_1, KC_2, KC_3, KC_DOT, KC_EQUAL,
        KC_ENTER, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_0),
    [2] = LAYOUT_voyager(
        RGB_TOG, TOGGLE_LAYER_COLOR, RGB_MOD, RGB_SLD, RGB_VAD, RGB_VAI,
        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
        KC_TRANSPARENT, RESET, KC_TRANSPARENT, KC_TRANSPARENT,
        KC_AUDIO_VOL_DOWN, KC_AUDIO_VOL_UP, KC_AUDIO_MUTE, KC_TRANSPARENT,
        KC_PGUP, KC_HOME, KC_UP, KC_END, KC_TRANSPARENT, KC_TRANSPARENT,
        KC_TRANSPARENT, KC_MEDIA_PREV_TRACK, KC_MEDIA_NEXT_TRACK, KC_MEDIA_STOP,
        KC_MEDIA_PLAY_PAUSE, KC_TRANSPARENT, KC_PGDOWN, KC_LEFT, KC_DOWN,
        KC_RIGHT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
        KC_TRANSPARENT, KC_TRANSPARENT, HSV_0_255_255, HSV_74_255_255,
        HSV_169_255_255, KC_TRANSPARENT, LCTL(LSFT(KC_TAB)), LCTL(KC_TAB),
        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT),
};

extern rgb_config_t rgb_matrix_config;

void keyboard_post_init_user(void) { rgb_matrix_enable(); }

const uint8_t PROGMEM ledmap[][DRIVER_LED_TOTAL][3] = {
    [0] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 245, 245}, {41, 255, 255}, {139, 216, 181},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}, {0, 0, 0},     {0, 0, 0},      {0, 0, 0},
           {0, 0, 0}, {0, 0, 0}},

};

void set_layer_color(int layer) {
  for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
    HSV hsv = {
        .h = pgm_read_byte(&ledmap[layer][i][0]),
        .s = pgm_read_byte(&ledmap[layer][i][1]),
        .v = pgm_read_byte(&ledmap[layer][i][2]),
    };
    if (!hsv.h && !hsv.s && !hsv.v) {
      rgb_matrix_set_color(i, 0, 0, 0);
    } else {
      RGB rgb = hsv_to_rgb(hsv);
      float f = (float)rgb_matrix_config.hsv.v / UINT8_MAX;
      rgb_matrix_set_color(i, f * rgb.r, f * rgb.g, f * rgb.b);
    }
  }
}

void rgb_matrix_indicators_user(void) {
  if (keyboard_config.disable_layer_led) {
    return;
  }
  switch (biton32(layer_state)) {
  case 0:
    set_layer_color(0);
    break;
  default:
    if (rgb_matrix_get_flags() == LED_FLAG_NONE)
      rgb_matrix_set_color_all(0, 0, 0);
    break;
  }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {

  case RGB_SLD:
    if (record->event.pressed) {
      rgblight_mode(1);
    }
    return false;
  case HSV_0_255_255:
    if (record->event.pressed) {
      rgblight_mode(1);
      rgblight_sethsv(0, 255, 255);
    }
    return false;
  case HSV_74_255_255:
    if (record->event.pressed) {
      rgblight_mode(1);
      rgblight_sethsv(74, 255, 255);
    }
    return false;
  case HSV_169_255_255:
    if (record->event.pressed) {
      rgblight_mode(1);
      rgblight_sethsv(169, 255, 255);
    }
    return false;
  }
  return true;
}

typedef struct {
  bool is_press_action;
  uint8_t step;
} tap;

enum {
  SINGLE_TAP = 1,
  SINGLE_HOLD,
  DOUBLE_TAP,
  DOUBLE_HOLD,
  DOUBLE_SINGLE_TAP,
  MORE_TAPS
};

static tap dance_state[1];

uint8_t dance_step(qk_tap_dance_state_t *state);

uint8_t dance_step(qk_tap_dance_state_t *state) {
  if (state->count == 1) {
    if (state->interrupted || !state->pressed)
      return SINGLE_TAP;
    else
      return SINGLE_HOLD;
  } else if (state->count == 2) {
    if (state->interrupted)
      return DOUBLE_SINGLE_TAP;
    else if (state->pressed)
      return DOUBLE_HOLD;
    else
      return DOUBLE_TAP;
  }
  return MORE_TAPS;
}

void on_dance_0(qk_tap_dance_state_t *state, void *user_data);
void dance_0_finished(qk_tap_dance_state_t *state, void *user_data);
void dance_0_reset(qk_tap_dance_state_t *state, void *user_data);

void on_dance_0(qk_tap_dance_state_t *state, void *user_data) {
  if (state->count == 3) {
    tap_code16(KC_EQUAL);
    tap_code16(KC_EQUAL);
    tap_code16(KC_EQUAL);
  }
  if (state->count > 3) {
    tap_code16(KC_EQUAL);
  }
}

void dance_0_finished(qk_tap_dance_state_t *state, void *user_data) {
  dance_state[0].step = dance_step(state);
  switch (dance_state[0].step) {
  case SINGLE_TAP:
    register_code16(KC_EQUAL);
    break;
  case SINGLE_HOLD:
    register_code16(KC_ESCAPE);
    break;
  case DOUBLE_TAP:
    register_code16(KC_EQUAL);
    register_code16(KC_EQUAL);
    break;
  case DOUBLE_SINGLE_TAP:
    tap_code16(KC_EQUAL);
    register_code16(KC_EQUAL);
  }
}

void dance_0_reset(qk_tap_dance_state_t *state, void *user_data) {
  wait_ms(10);
  switch (dance_state[0].step) {
  case SINGLE_TAP:
    unregister_code16(KC_EQUAL);
    break;
  case SINGLE_HOLD:
    unregister_code16(KC_ESCAPE);
    break;
  case DOUBLE_TAP:
    unregister_code16(KC_EQUAL);
    break;
  case DOUBLE_SINGLE_TAP:
    unregister_code16(KC_EQUAL);
    break;
  }
  dance_state[0].step = 0;
}

qk_tap_dance_action_t tap_dance_actions[] = {
    [DANCE_0] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_0, dance_0_finished,
                                             dance_0_reset),
};
