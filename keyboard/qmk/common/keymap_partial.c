// good tutorial:
// https://precondition.github.io/home-row-mods

/*

# Design philosophy/decisions

Mainly, this is a keyboard for linux, windows, and macos. This causes many of
the design decisions. When possible, we want a key to have the same
functionality across all OS.


## Dedicated modifier keys

Have keys that are always ALT, SFT, and CTL, independent on OS. These CTL keys
can be used for apps that use the CTL key on each OS, such as the terminal.


## Modifier changes on OS

Have keys that are CTL on linux/windows, and GUI on macos. This is the major
modifier and used for most shortcuts on each OS, such as
copy/paste/newtab/addressbar/etc.

Vice versa, have keys that are GUI on linux/windows, and CTL on macos. This in
the minor modifier.

(We use QK_MAGIC_SWAP_LCTL_LGUI to make the change.)


## Navigation

The navigational keys work slightly different on the OS as well. Backspace
(called delete on macos) is included here.

Movement:
* Move by one character or line:
  --> UP/DOWN/LEFT/RIGHT on all OS
* Move by one word:
  - CTL+LEFT/RIGHT on linux/windows
  - ALT+LEFT/RIGHT on macos
  --> Must be implemented individually
* Move to beginning/end of line:
  - HOME/END on linux/windows
  - GUI+LEFT/RIGHT on macos. HOME/END also work if keyboard has these keys.
  --> HOME/END on all OS
  --> update: HOME/END does not work in firefox on macos. So, handle
individually instead.
* Move to beginning/end of document:
  - CTL+HOME/END on linux/windows
  - GUI+UP/DOWN on macos (doesn't work on my machine). GUI+HOME/END also works
if keyboard has these keys
  --> MAJOR+HOME/END on all OS
* Move to beginning/end of paragraph:
  - ??? on linux/windows
  - GUI+UP/DOWN or ALT+UP/DOWN on macos
  --> TODO: decide implement or not.

Selection:
* Select one character or line, or one word, or until beginning/end of line, or
until beginning/end of document: SFT+movement.
  --> Not implemented on dedicated keys. User must press SFT.

Removal:
* Remove one character:
  --> BACKSPACE/DELETE on all OS
* Remove one word:
  - CTL+BACKSPACE/DELETE on linux/windows
  - ALT+BACKSPACE/DELETE on macos. GUI+BACKSPACE/DELETE also works.
  --> MAJOR+BACKSPACE/DELETE on all OS
* Remove to beginning/end of line:
  --> Not implemented as custom key.


## Web browsing

For many shortcuts (new tab, close tab, reopen tab, focus addressbar, ...),
Firefox uses the MAJOR modifier + the same key on all OS. However, some
often-used shortcuts do not, and must be handled seperately:
* Back/Forward in history.
  - ALT+LEFT/RIGHT on linux/windows
  - GUI+LEFT/RIGHT on macos
  --> Must be implemented individually
* Left or right tab.
  - CTL+PGUP/PGDN on linux/windows
  - GUI+ALT+LEFT/RIGHT (overridden for window management on my machine) or
CTL+PGUP/PGDN on macos
  --> Must be implemented individually
* Move current tab to left or right
  --> Same, but with SFT
  --> Not implemented as custom key.

*
*
*/

/*
 * TODOS:
 * * Make HOME/END function the same on win/linux and macos.
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
  L_SYSTEM,
  L_GAME
};
enum custom_keycodes {
  kcLINUX = SAFE_RANGE,
  kcWINDO,
  kcMACOS,
  kcWEB,
  kcPrevWord,
  kcNextWord,
  kcBspWord,
  kcDelWord,
  kcWebBack,
  kcWebFwd,
  kcCycleApp,
  kcCycleWin,
  kcShowApp,
  kcShowWin,
  kcOpenApp,
  RGB_SLD
};
enum supported_os {
  LINUX = 1,
  WINDOWS = 2,
  MACOS = 3
}; // some functionality depends on the operating system.

// These must be implemented in the keymap.c file of each specific keyboard.
void custom_led_indicators(enum supported_os os);
void custom_post_init(void);

// clang-format off

// Aliases.

// Special keys
#define ___f___  _______ // transparent by design; must remain empty e.g. to capture underlying layer keys

// Modifiers (no prefix if function, "kc" if keycode (=modifier while held), "mod_..." if used in macro)
// . modifier, always ALT
#undef A
#define A(kc)      LALT(kc) //function
#define ALT(kc)    LALT(kc) //function
#define kc_ALT     KC_LALT  //key
#define mod_ALT    MOD_LALT //modifier in home-row mods
// . modifier, always SFT
#define SFT(kc)    LSFT(kc)
#define kc_SFT     KC_LSFT
#define mod_SFT    MOD_LSFT
// . modifier, always CTL
#undef C
#define C(kc)      LCTL(kc)
#define CTL(kc)    LCTL(kc)
#define kc_CTL     KC_LCTL
#define mod_CTL    MOD_LCTL
// . modifier, always GUI
#undef G
#define G(kc)      LGUI(kc)
#define GUI(kc)    LGUI(kc)
#define kc_GUI     KC_LGUI
#define mod_GUI    MOD_LGUI
// . major modifier, is CTL on linux and GUI (=command) on mac
#define J(kc)      RCTL(kc)
#define MAJ(kc)    RCTL(kc)
#define kc_MAJOR   KC_RCTL
#define mod_MAJOR  MOD_RCTL
// . minor modifier, is GUI (=win/meta) on linux and CTL on mac
#define N(kc)      RGUI(kc)
#define MNR(kc)    RGUI(kc)
#define kc_MINOR   KC_RGUI
#define mod_MINOR  MOD_RGUI

// Layer switching ("l..." if layer while held; "p..." for permanent switch)
#define l_DOT    LT(L_SYM, KC_DOT)
#define l_P      LT(L_NUM, KC_P)
#define l_Y      LT(L_FUN, KC_Y)
#define l_G      LT(L_FUN, KC_G)
#define l_C      LT(L_SYM, KC_C)
#define l_X      LT(L_MOUSE, KC_X)
#define l_K      LT(L_NUM, KC_K)
#define l_B      LT(L_MOUSE, KC_B)
#define l_TAB    LT(L_NAV, KC_TAB)
#define l_SPC    LT(L_NAV, KC_SPC)
#define lNAV     MO(L_NAV)
#define lNAV2    MO(L_NAV2)
#define pGAME    TO(L_GAME)
#define pBASE    TO(L_BASE)

// Mods ("c_..." if CTL when held; s_ if SFT; a_ if ALT; g_ if GUI; j_ if MAJOR; n_ if MINOR.)
// . home-row mods
#define ctl_SCLN MT(mod_CTL, KC_SCLN)
#define mnr_SCLN MT(mod_MINOR, KC_SCLN)
#define mnr_A    MT(mod_MINOR, KC_A)
#define ctl_A    MT(mod_CTL, KC_A)
#define sft_O    MT(mod_SFT, KC_O)
#define maj_E    MT(mod_MAJOR, KC_E)
#define alt_U    MT(mod_ALT, KC_U)
#define alt_H    MT(mod_ALT, KC_H)
#define maj_T    MT(mod_MAJOR, KC_T)
#define sft_N    MT(mod_SFT, KC_N)
#define mnr_S    MT(mod_MINOR, KC_S)
#define ctl_S    MT(mod_CTL, KC_S)
#define mnr_Z    MT(mod_MINOR, KC_Z)
#define ctl_Z    MT(mod_CTL, KC_Z)
// . other mods
#define mWM      ALT(kc_GUI)
#define sft_TAB  MT(mod_SFT, KC_TAB)
#define sft_BSPC MT(mod_SFT, KC_BSPC)

// Special functions ("f...")
#define fEE_CLR  QK_CLEAR_EEPROM // if something gets mixed up, this will clear the persistent values.



// Layouts.

#define LAYER_BASE \
    KC_QUOT   ,KC_COMM   ,l_DOT     ,l_P       ,l_Y       ,                      KC_F      ,l_G       ,l_C       ,KC_R      ,KC_L      ,\
    ctl_A     ,sft_O     ,maj_E     ,alt_U     ,KC_I      ,                      KC_D      ,alt_H     ,maj_T     ,sft_N     ,ctl_S     ,\
    mnr_SCLN  ,KC_Q      ,KC_J      ,l_K       ,l_X       ,KC_VOLD   ,KC_VOLU   ,l_B       ,KC_M      ,KC_W      ,KC_V      ,mnr_Z     ,\
    KC_ESC    ,XXXXXXX   ,XXXXXXX   ,mWM       ,l_SPC     ,kcLINUX   ,kcMACOS   ,sft_BSPC  ,l_TAB     ,XXXXXXX   ,XXXXXXX   ,KC_ENT

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
    kc_CTL    ,kc_SFT    ,kc_MAJOR  ,kc_ALT    ,XXXXXXX   ,                      KC_MINS   ,KC_LPRN   ,KC_RPRN   ,KC_EQL    ,KC_UNDS   ,\
    KC_AT     ,KC_PERC   ,KC_QUES   ,KC_EXLM   ,XXXXXXX   ,_______   ,_______   ,KC_PLUS   ,KC_LCBR   ,KC_RCBR   ,KC_PIPE   ,KC_ASTR   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,___f___   ,___f___   ,_______   ,_______   ,___f___

#define LAYER_NUM \
    KC_QUOT   ,KC_COMM   ,KC_DOT    ,___f___   ,KC_CIRC   ,                      KC_0      ,KC_1      ,KC_2      ,KC_3      ,KC_SLSH   ,\
    kc_MINOR  ,kc_SFT    ,kc_MAJOR  ,kc_ALT    ,XXXXXXX   ,                      KC_MINUS  ,KC_4      ,KC_5      ,KC_6      ,KC_UNDS   ,\
    KC_COLN   ,KC_PERC   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,_______   ,_______   ,KC_PLUS   ,KC_7      ,KC_8      ,KC_9      ,KC_ASTR   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,_______   ,___f___   ,_______   ,_______   ,___f___


//  Win of app Win of app Apps       Apps       Copy                             DocStart   LineStart  PageUp     PageDown   LineEnd
//  (cycle)    (show all) (show all) (cycle)                                                           
//    
//  CTL        SFT        MAJOR      WebButton  Paste                            DocEnd     Left       Up         Down       Right
//                                                                                          
//  MINOR      zoom out   zoom in    applaunchr Cut                              DelWord    Del        PrevWord   NextWord   Insert
//             
//                                                                               BspWord
#define LAYER_NAV \
    kcCycleWin,kcShowWin ,kcShowApp ,kcCycleApp,J(KC_C)   ,                      J(KC_HOME),KC_HOME   ,KC_PGUP   ,KC_PGDN   ,KC_END    ,\
    kc_CTL    ,kc_SFT    ,kc_MAJOR  ,lNAV2     ,J(KC_V)   ,                      J(KC_END) ,KC_LEFT   ,KC_UP     ,KC_DOWN   ,KC_RGHT   ,\
    kc_MINOR  ,J(KC_MINS),J(KC_EQL) ,kcOpenApp ,J(KC_X)   ,KC_MPRV   ,KC_MNXT   ,kcDelWord ,KC_DEL    ,kcPrevWord,kcNextWord,KC_INS    ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,KC_MPLY   ,KC_MUTE   ,kcBspWord,_______   ,_______   ,_______   ,___f___

#define LAYER_NAV2 \
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,C(KC_PGUP),C(KC_PGDN),_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,kcWebBack ,C(KC_PGUP),C(KC_PGDN),kcWebFwd  ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______

#define LAYER_FUN \
    KC_F1     ,KC_F2     ,KC_F3     ,KC_F4     ,___f___   ,                      XXXXXXX   ,___f___   ,kc_ALT    ,XXXXXXX   ,XXXXXXX   ,\
    KC_F5     ,KC_F6     ,KC_F7     ,KC_F8     ,kc_ALT    ,                      XXXXXXX   ,kc_ALT    ,kc_MAJOR  ,kc_SFT    ,kc_CTL    ,\
    KC_F9     ,KC_F10    ,KC_F11    ,KC_F12    ,XXXXXXX   ,_______   ,_______   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,kc_MINOR  ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,___f___   ,___f___   ,_______   ,_______   ,_______

#define LAYER_MOUSE \
    KC_WH_U   ,KC_BTN1   ,KC_MS_U   ,KC_BTN2   ,QK_BOOT   ,                      pGAME     ,KC_BTN1   ,KC_MS_U   ,KC_BTN2   ,KC_WH_U   ,\
    KC_WH_D   ,KC_MS_L   ,KC_MS_D   ,KC_MS_R   ,fEE_CLR   ,                      XXXXXXX   ,KC_MS_L   ,KC_MS_D   ,KC_MS_R   ,KC_WH_D   ,\
    KC_ACL0   ,KC_ACL1   ,KC_ACL2   ,XXXXXXX   ,___f___   ,_______   ,_______   ,___f___   ,XXXXXXX   ,KC_ACL2   ,KC_ACL1   ,KC_ACL0   ,\
    ___f___   ,_______   ,_______   ,pBASE     ,___f___   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______

#define LAYER_GAME \
    KC_Q      ,KC_W      ,KC_E      ,KC_R      ,KC_T      ,                      KC_Y      ,KC_U      ,KC_I      ,KC_O      ,KC_P      ,\
    KC_A      ,KC_S      ,KC_D      ,KC_F      ,KC_G      ,                      KC_H      ,KC_J      ,KC_K      ,KC_L      ,KC_SCLN   ,\
    KC_Z      ,KC_X      ,KC_C      ,KC_V      ,KC_B      ,_______   ,_______   ,KC_N      ,KC_M      ,KC_UP     ,KC_DOT    ,KC_SLSH   ,\
    _______   ,kc_SFT    ,_______   ,pBASE     ,_______   ,_______   ,_______   ,_______   ,KC_LEFT   ,KC_DOWN   ,KC_RGHT   ,_______

#define LAYER_SYSTEM \
    _______   ,_______   ,_______   ,_______   ,_______   ,                      KC_MPLY   ,KC_MPRV   ,KC_MNXT   ,_______   ,KC_BRIU   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,                      KC_MUTE   ,KC_VOLD   ,KC_VOLU   ,_______   ,KC_BRID   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,KC_LCAP   ,KC_INS    ,\
    _______   ,_______   ,_______   ,_______   ,___f___   ,_______   ,_______   ,___f___   ,_______   ,_______   ,_______   ,_______

#define LAYER_TEMPLATE \
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______

// clang-format on

// Functions.

bool get_tapping_force_hold(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
  case l_SPC: // ensure that tap-then-hold on space bar sends repeated spaces
    return false;
  default:
    return true;
  }
}

enum supported_os current_os = 0;

void set_current_os_from_keycode(uint16_t keycode) {
  // Process the MAGIC keycodes manually. Reason: avoid persistently storing the
  // value. Upon reboot, the modifiers are always UNSWAPPED.
  switch (keycode) {
  case kcLINUX:
    current_os = LINUX;
    keymap_config.swap_rctl_rgui = false;
    break;
  case kcWINDO:
    current_os = WINDOWS;
    keymap_config.swap_rctl_rgui = false;
    break;
  case kcMACOS:
    current_os = MACOS;
    keymap_config.swap_rctl_rgui = true;
    break;
  }
  // send alt-gui-f2 to set to us layout.
  tap_code16(ALT(GUI(KC_F2)));
  custom_led_indicators(current_os);
}
void linwinmac(uint16_t linuxcode, uint16_t windowscode, uint16_t macoscode,
               bool tap, keyrecord_t *record) {
  // Send correct keycode, depending on the current OS.
  uint16_t code;
  // get code
  if (current_os == LINUX) {
    code = linuxcode;
  } else if (current_os == WINDOWS) {
    code = windowscode;
  } else { // current_os == MACOS
    code = macoscode;
  }
  // execute
  if (!tap) {
    if (record->event.pressed) {
      register_code16(code);
    } else {
      unregister_code16(code);
    }
  } else if (record->event.pressed) {
    tap_code16(code);
  }
}
layer_state_t layer_state_set_user(layer_state_t state) {
  // Restore modifier state to 'no modifiers'.
  static uint8_t prev_layer;
  if (prev_layer == L_NAV) {
    if (current_os == LINUX || current_os == WINDOWS) {
      unregister_code(kc_ALT);
      unregister_code(kc_CTL);
    } else { // MACOS
      unregister_code(kc_GUI);
    }
  }
  prev_layer = get_highest_layer(state);
  return state;
}
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  // Custom processing of keypresses.
  switch (keycode) {
  case kcLINUX:
  case kcWINDO:
  case kcMACOS:
    if (!record->event.pressed) {
      set_current_os_from_keycode(keycode);
    }
    return false; // don't continue processing this key

  case l_K:
    if (!record->tap.count) {
      if (record->event.pressed) {
        register_code(kc_ALT);
        register_code(kc_GUI);
      } else {
        unregister_code(kc_ALT);
        unregister_code(kc_GUI);
      }
    }
    return true;

  case KC_HOME:
  case KC_END:
    // HOME and END work fine on linux and windows
    if (current_os != MACOS) {
      return true;
    }
    // on mac, tap GUI+LEFT/RIGHT instead
    if (record->event.pressed) {
      uint16_t kc = (keycode == KC_HOME) ? KC_LEFT : KC_RIGHT;
      tap_code16(GUI(kc));
    }
    return false;

  case kcBspWord:
    linwinmac(C(KC_BSPC), C(KC_BSPC), ALT(KC_BSPC), true, record);
    return false;

  case kcDelWord:
    linwinmac(C(KC_DEL), C(KC_DEL), ALT(KC_DEL), true, record);
    return false;

  case kcPrevWord:
    linwinmac(C(KC_LEFT), CTL(KC_LEFT), ALT(KC_LEFT), false, record);
    return false;

  case kcNextWord:
    linwinmac(CTL(KC_RIGHT), CTL(KC_RIGHT), ALT(KC_RIGHT), false, record);
    return false;

  case kcWebBack:
    linwinmac(ALT(KC_LEFT), ALT(KC_LEFT), GUI(KC_LEFT), true, record);
    return false;

  case kcWebFwd:
    linwinmac(ALT(KC_RIGHT), ALT(KC_RIGHT), GUI(KC_RIGHT), true, record);
    return false;

  case kcOpenApp:
    linwinmac(kc_GUI, kc_GUI, GUI(KC_SPACE), true, record);
    return false;

  case kcCycleApp:
    if (record->event.pressed) {
      if (current_os == LINUX || current_os == WINDOWS) {
        set_mods(mod_ALT);
        tap_code(KC_TAB);
      } else { // MACOS
        set_mods(mod_GUI);
        tap_code(KC_TAB);
      }
    }
    return false;

  case kcShowApp:
    if (record->event.pressed) {
      if (current_os == LINUX || current_os == WINDOWS) {
        unregister_code(kc_ALT); // in case we were alt-tabbing
        tap_code16(C(KC_ESC));
      } else { // MACOS
        unregister_code(kc_GUI);
        tap_code16(CTL(KC_UP));
      }
    }
    return false;

  case kcShowWin:
    if (record->event.pressed) {
      if (current_os == LINUX || current_os == WINDOWS) {
        unregister_code(kc_ALT); // in case we were alt-tabbing
        tap_code16(GUI(KC_D));
      } else { // MACOS
        unregister_code(kc_GUI);
        tap_code16(CTL(KC_DOWN));
      }
    }
    return false;

  case kcCycleWin:
    if (record->event.pressed) {
      if (current_os == LINUX || current_os == WINDOWS) {
        unregister_code(kc_ALT); // in case we were alt-tabbing
        set_mods(mod_CTL);
        tap_code(KC_TAB);
      } else { // MACOS
        set_mods(mod_GUI);
        tap_code(KC_GRV);
      }
    }
    return false;

  default:
    return true; // Process all other keycodes normally
  }
}

void keyboard_post_init_user(void) {
  set_current_os_from_keycode(kcLINUX);
  custom_post_init();
}
