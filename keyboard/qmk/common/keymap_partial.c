// good tutorial:
// https://precondition.github.io/home-row-mods

/*
 * Design philosophy:
 *
 * * Keyboard for mac, windows and linux
 *
 * * Have keys that are always ALT, SFT, and CTL, independent on OS.
 *   These CTL keys can be used for apps that use the CTL key on each OS, such
 *   as the terminal.
 *
 * * Have keys that are CTL on windows and linux, and GUI on mac.
 *   This is the major modifier and used for most shortcuts on each OS, such as
 *   copy/paste/newtab/addressbar/etc.
 * * Have keys that are GUI on windows and linux, and CTL on mac.
 *   This in the minor modifier.
 * * Use QK_MAGIC_SWAP_LCTL_LGUI to make the change.
 *
 */

/*
 * TODOS:
 * * Make HOME/END function the same on win/linux and macos.
 * * Make navigation-per-word work the same on win/linux and macos.
 *   - ctrl+arrow (linux/win) vs alt+arrow (macos)
 *   - ctrl+delete (linux/win) vs alt+delet (macos)
 *   - ctrl+pgup/pgdown
 *   - ctrl+home/end
 *   - ...?
 *
 * * Use leader key for GUI+ALT (window management shortcuts)
 *
 * * Alt-TAB (linux/wi) vs GUI-TAB (mocas)
 */

#include QMK_KEYBOARD_H
#include "version.h"

// enums

enum layer_names {
  L_BASE,
  L_BASE2,
  L_SYM,
  L_NUM,
  L_NAV,
  L_NAV2,
  L_FUN,
  L_MOUSE,
  L_GAME
};
// Some functionality depends on the operating system.
enum custom_keycodes { kcLINUX = SAFE_RANGE, kcWINDO, kcMACOS };
enum supported_os { LINUX = 1, WINDOWS = 2, MACOS = 3 };

void led_indicators(enum supported_os os); // to be implemented in keymap.c
// clang-format off

// Aliases.

// Special keys
#define ___f___  _______ // transparent by design; must remain empty e.g. to capture underlying layer keys

// Modifiers (no prefix if function, "kc" if keycode (=modifier while held), "mod_..." if used in macro)
// . modifier, always ALT
#define ALT        RALT //function
#define kcALT      KC_RALT //key 
#define mod_ALT    MOD_RALT //modifier in home-row mods
// . modifier, always SFT
#define kcSFT      KC_RSFT     
#define mod_SFT    MOD_RSFT     
// . modifier, always CTL
#define kcCTL      KC_RCTL
#define mod_CTL    MOD_RCTL
// . modifier, always GUI
#define kcGUI      KC_RGUI
#define mod_GUI    MOD_RGUI
// . major modifier, is CTL on linux and GUI (=command) on mac
#define MAJOR      LCTL
#define kcMAJOR    KC_LCTL     
#define mod_MAJOR  MOD_LCTL     
// . minor modifier, is GUI (=win/meta) on linux and CTL on mac
#define MINOR      LGUI
#define kcMINOR    KC_LGUI     
#define mod_MINOR  MOD_LGUI     

// Layer switching ("l..." if layer while held; "p..." for permanent switch)
#define lKC_DOT  LT(L_SYM, KC_DOT)
#define lKC_P    LT(L_NUM, KC_P)
#define lKC_Y    LT(L_FUN, KC_Y)
#define lKC_G    LT(L_FUN, KC_G)
#define lKC_C    LT(L_SYM, KC_C)
#define lKC_K    LT(L_MOUSE, KC_K)
#define lKC_M    LT(L_MOUSE, KC_M)
#define lNAV     MO(L_NAV)
#define lKC_TAB  LT(L_NAV, KC_TAB)
#define lKC_SPC  LT(L_NAV, KC_SPC) 
#define lNAV2    MO(L_NAV2)
#define pGAME    TO(L_GAME)
#define pBASE    TO(L_BASE)

// Mods ("m..." if modifier while held)
// . home-row mods
#define mKC_SCLN MT(mod_CTL, KC_SCLN) 
#define mKC_A    MT(mod_MINOR, KC_A) 
#define mKC_O    MT(mod_SFT, KC_O)
#define mKC_E    MT(mod_MAJOR, KC_E)
#define mKC_U    MT(mod_ALT, KC_U)
#define mKC_H    MT(mod_ALT, KC_H)
#define mKC_T    MT(mod_MAJOR, KC_T) 
#define mKC_N    MT(mod_SFT, KC_N)
#define mKC_S    MT(mod_MINOR, KC_S) 
#define mKC_Z    MT(mod_CTL, KC_Z) 
// . other mods
#define mWM      ALT(kcGUI) 

// Special functions ("f...")
// . copy/paste/cut
#define fCUT     MAJOR(KC_X)
#define fCOPY    MAJOR(KC_C)
#define fPASTE   MAJOR(KC_V)
#define fEE_CLR  QK_CLEAR_EEPROM // if something gets mixed up, this will clear the persistent values. 



// Layouts.

#define LAYER_BASE \
    KC_QUOT   ,KC_COMM   ,lKC_DOT   ,lKC_P     ,lKC_Y     ,                      KC_F      ,lKC_G     ,lKC_C     ,KC_R      ,KC_L      ,\
    mKC_A     ,mKC_O     ,mKC_E     ,mKC_U     ,KC_I      ,                      KC_D      ,mKC_H     ,mKC_T     ,mKC_N     ,mKC_S     ,\
    mKC_SCLN  ,KC_Q      ,KC_J      ,lKC_K     ,KC_X      ,KC_VOLD   ,KC_VOLU   ,KC_B      ,lKC_M     ,KC_W      ,KC_V      ,mKC_Z     ,\
    KC_ESC    ,XXXXXXX   ,XXXXXXX   ,mWM       ,lKC_SPC   ,kcLINUX  /*  */ ,kcMACOS    ,KC_BSPC   ,lKC_TAB   ,XXXXXXX   ,XXXXXXX   ,KC_ENT

//Dvorak without modifiers. Never switched to, just as base for the combos
#define LAYER_BASE2 \
    KC_QUOT   ,KC_COMM   ,KC_DOT    ,KC_P      ,KC_Y      ,                      KC_F      ,KC_G      ,KC_C      ,KC_R      ,KC_L      ,\
    KC_A      ,KC_O      ,KC_E      ,KC_U      ,KC_I      ,                      KC_D      ,KC_H      ,KC_T      ,KC_N      ,KC_S      ,\
    KC_SCLN   ,KC_Q      ,KC_J      ,KC_K      ,KC_X      ,XXXXXXX   ,XXXXXXX   ,KC_B      ,KC_M      ,KC_W      ,KC_V      ,KC_Z      ,\
    XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX

//  `          %          #          $          ^                                &          [          ]          \          /
//                                                                               -          (          )          =          _
//  @          ~          ?          !                                           +          {          }          |          *
#define LAYER_SYM \
    KC_GRV    ,KC_TILD   ,KC_HASH   ,KC_DLR    ,KC_CIRC   ,                      KC_AMPR   ,KC_LBRC   ,KC_RBRC   ,KC_BSLS   ,KC_SLSH   ,\
    kcMINOR   ,kcSFT     ,kcMAJOR   ,kcALT     ,XXXXXXX   ,                      KC_MINS   ,KC_LPRN   ,KC_RPRN   ,KC_EQL    ,KC_UNDS   ,\
    KC_AT     ,KC_PERC   ,KC_QUES   ,KC_EXLM   ,XXXXXXX   ,_______   ,_______   ,KC_PLUS   ,KC_LCBR   ,KC_RCBR   ,KC_PIPE   ,KC_ASTR   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,___f___   ,___f___   ,_______   ,_______   ,___f___

#define LAYER_NUM \
    KC_QUOT   ,KC_COMM   ,KC_DOT    ,___f___   ,KC_CIRC   ,                      KC_0      ,KC_1      ,KC_2      ,KC_3      ,KC_SLSH   ,\
    kcMINOR   ,kcSFT     ,kcMAJOR   ,kcALT     ,XXXXXXX   ,                      KC_MINUS  ,KC_4      ,KC_5      ,KC_6      ,KC_UNDS   ,\
    KC_COLN   ,KC_PERC   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,_______   ,_______   ,KC_PLUS   ,KC_7      ,KC_8      ,KC_9      ,KC_ASTR   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,_______   ,___f___   ,_______   ,_______   ,___f___

#define LAYER_NAV \
    KC_HOME   ,KC_PGUP   ,KC_PGDN   ,KC_END    ,fCOPY     ,                      fCOPY     ,KC_HOME   ,KC_PGUP   ,KC_PGDN   ,KC_END    ,\
    kcMINOR   ,kcSFT     ,kcMAJOR   ,kcALT     ,fPASTE    ,                      fPASTE    ,KC_LEFT   ,KC_UP     ,KC_DOWN   ,KC_RGHT   ,\
    KC_BTN1   ,KC_BTN2   ,XXXXXXX   ,KC_DEL    ,fCUT      ,KC_MPRV   ,KC_MNXT   ,fCUT      ,KC_DEL    ,KC_INS    ,KC_CAPS   ,KC_SCRL   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,KC_MPLY   ,KC_MUTE   ,___f___   ,_______   ,_______   ,_______   ,___f___

#define LAYER_NAV2 \
    C(KC_HOME),C(KC_PGUP),C(KC_PGDN),C(KC_END) ,fCOPY     ,                      fCOPY     ,C(KC_HOME),C(KC_PGUP),C(KC_PGDN),C(KC_END) ,\
    kcMINOR   ,kcSFT     ,kcMAJOR   ,kcALT     ,fPASTE    ,                      fPASTE    ,C(KC_LEFT),C(KC_UP)  ,C(KC_DOWN),C(KC_RGHT),\
    KC_BTN1   ,KC_BTN2   ,XXXXXXX   ,C(KC_DEL) ,fCUT      ,_______   ,_______   ,fCUT      ,C(KC_DEL) ,KC_INS    ,KC_CAPS   ,KC_SCRL   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,C(KC_SPC) ,_______   ,_______   ,C(KC_BSPC),_______   ,_______   ,_______   ,C(KC_ENT)

#define LAYER_FUN \
    KC_F1     ,KC_F2     ,KC_F3     ,KC_F4     ,___f___   ,                      XXXXXXX   ,___f___   ,kcALT     ,XXXXXXX   ,XXXXXXX   ,\
    KC_F5     ,KC_F6     ,KC_F7     ,KC_F8     ,kcALT     ,                      XXXXXXX   ,kcALT     ,kcMAJOR   ,kcSFT     ,kcMINOR   ,\
    KC_F9     ,KC_F10    ,KC_F11    ,KC_F12    ,XXXXXXX   ,_______   ,_______   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,kcCTL     ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,___f___   ,___f___   ,_______   ,_______   ,_______

#define LAYER_MOUSE \
    KC_WH_U   ,KC_BTN1   ,KC_MS_U   ,KC_BTN2   ,QK_BOOT   ,                      pGAME     ,KC_BTN1   ,KC_MS_U   ,KC_BTN2   ,KC_WH_U   ,\
    KC_WH_D   ,KC_MS_L   ,KC_MS_D   ,KC_MS_R   ,fEE_CLR   ,                      XXXXXXX   ,KC_MS_L   ,KC_MS_D   ,KC_MS_R   ,KC_WH_D   ,\
    KC_ACL0   ,KC_ACL1   ,KC_ACL2   ,___f___   ,XXXXXXX   ,_______   ,_______   ,XXXXXXX   ,___f___   ,KC_ACL2   ,KC_ACL1   ,KC_ACL0   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______

#define LAYER_GAME \
    KC_Q      ,KC_W      ,KC_E      ,KC_R      ,KC_T      ,                      KC_Y      ,KC_U      ,KC_I      ,KC_O      ,KC_P      ,\
    KC_A      ,KC_S      ,KC_D      ,KC_F      ,KC_G      ,                      KC_H      ,KC_J      ,KC_K      ,KC_L      ,KC_SCLN   ,\
    KC_Z      ,KC_X      ,KC_C      ,KC_V      ,KC_B      ,_______   ,_______   ,KC_N      ,KC_M      ,KC_UP     ,KC_DOT    ,KC_SLSH   ,\
    _______   ,kcSFT     ,_______   ,pBASE     ,_______   ,_______   ,_______   ,_______   ,KC_LEFT   ,KC_DOWN   ,KC_RGHT   ,_______

#define LAYER_TEMPLATE \
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______

// clang-format on

// Functions.

bool get_tapping_force_hold(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case lKC_SPC: // ensure that tap-then-hold on space bar sends repeated spaces
    return false;
  default:
    return true;
  }
}

enum supported_os current_os = 0;

void set_current_os_from_keycode(uint16_t keycode) {
  switch (keycode) {
  case kcLINUX:
    current_os = LINUX;
    keymap_config.swap_lctl_lgui = false;
    break;
  case kcWINDO:
    current_os = WINDOWS;
    keymap_config.swap_lctl_lgui = false;
    break;
  case kcMACOS:
    current_os = MACOS;
    keymap_config.swap_lctl_lgui = true;
    break;
  }
  led_indicators(current_os);
}
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  // Process the MAGIC keycodes manually. Reason: avoid persistently storing
  // the value. Upon reboot, the modifiers are always UNSWAPPED.
  switch (keycode) {
  case kcLINUX:
  case kcWINDO:
  case kcMACOS:
    if (!record->event.pressed) {
      set_current_os_from_keycode(keycode);
    }
    return false; // don't continue processing this key
  case KC_LEFT:
  case KC_UP:
  case KC_DOWN:
  case KC_RGHT:; // semicolon needed to allow variable declaration on next line
    uint8_t mods = get_mods();

    // No modifiers: process as normal.
    if (mods == 0)
      return true;

    // If we reach here, a modifier was pressed.
    // static uint8_t kc; // to save state
    if (record->event.pressed) {
      // Make ALT+DIR skip one word.
      if (mods == MOD_BIT(kcALT)) {
        if (current_os != MACOS) {
          set_mods(MOD_MASK_CTRL);
        }
      }
    } else {
      clear_mods();
    }
    return true;

  default:
    return true; // Process all other keycodes normally
  }
}
