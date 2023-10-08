// good tutorial:
// https://precondition.github.io/home-row-mods

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
    L_GAME,
};

// aliases
#define ___f___  _______ // transparent by design; must remain empty e.g. to capture underlying layer keys
// l = layer switching
#define lKC_DOT  LT(L_SYM, KC_DOT)
#define lKC_P    LT(L_NUM, KC_P)
#define lKC_Y    LT(L_FUN, KC_Y)
#define lKC_G    LT(L_FUN, KC_G)
#define lKC_C    LT(L_SYM, KC_C)
#define lKC_K    LT(L_MOUSE, KC_K)
#define lKC_M    LT(L_MOUSE, KC_M)
#define lNAV     MO(L_NAV)
#define lKC_TAB  LT(L_NAV, KC_TAB)
#define lNAV2    MO(L_NAV2)
#define lGAME    TO(L_GAME)
// m = modifiers
// . normal modifiers (alias to more easily see)
#define m_ALT    KC_LALT     // modifier, always ALT
#define m_SFT    KC_LSFT     // modifier, always SFT
#define m_CTL    KC_LCTL     // modifier, always CTL, on mac and on linux/windows
#define m_MAJOR  KC_RCTL     // major modifier, is CTL on linux and GUI (=command) on mac
#define m_MINOR  KC_RGUI     // minor modifier, is GUI (=win/meta) on linux and CTL on mac
// . on base layer
#define mKC_SPC  MT(MOD_LALT | MOD_LGUI, KC_SPC) // mod key for window manager. Uses LGUI instead of LGUI to not be affected by swap (see below)
// . on base layer
#define mKC_A    MT(MOD_RGUI, KC_A) // R so that it is always MINOR modifier
#define mKC_O    MT(MOD_LSFT, KC_O)
#define mKC_E    MT(MOD_RCTL, KC_E) // R so that it is always MAJOR modifier
#define mKC_U    MT(MOD_LALT, KC_U)
#define mKC_I    MT(MOD_LCTL, KC_I)
#define mKC_D    MT(MOD_LCTL, KC_D)
#define mKC_H    MT(MOD_LALT, KC_H)
#define mKC_T    MT(MOD_RCTL, KC_T) // R so that it is always MAJOR modifier
#define mKC_N    MT(MOD_LSFT, KC_N)
#define mKC_S    MT(MOD_RGUI, KC_S) // R so that it is always MINOR modifier
// f = special functions
// . copy/paste/cut
#define fCUT     RCTL(KC_X)
#define fCOPY    RCTL(KC_C)
#define fPASTE   RCTL(KC_V)
// . to put COMMAND (=LGUI) under middle finger when using Mac. 
#define fSWAP    QK_MAGIC_SWAP_RCTL_RGUI
#define fUNSWAP  QK_MAGIC_UNSWAP_RCTL_RGUI


#define LAYER_BASE \
    KC_QUOT   ,KC_COMM   ,lKC_DOT   ,lKC_P     ,lKC_Y     ,                      KC_F      ,lKC_G     ,lKC_C     ,KC_R      ,KC_L      ,\
    mKC_A     ,mKC_O     ,mKC_E     ,mKC_U     ,mKC_I     ,                      mKC_D     ,mKC_H     ,mKC_T     ,mKC_N     ,mKC_S     ,\
    KC_SCLN   ,KC_Q      ,KC_J      ,lKC_K     ,KC_X      ,KC_VOLD   ,KC_VOLU   ,KC_B      ,lKC_M     ,KC_W      ,KC_V      ,KC_Z      ,\
    KC_ESC    ,XXXXXXX   ,XXXXXXX   ,lNAV      ,mKC_SPC   ,fUNSWAP   ,fSWAP     ,KC_BSPC   ,lKC_TAB   ,_______   ,_______   ,KC_ENT

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
    m_MINOR   ,m_SFT     ,m_MAJOR   ,m_ALT     ,m_CTL     ,                      KC_MINS   ,KC_LPRN   ,KC_RPRN   ,KC_EQL    ,KC_UNDS   ,\
    KC_AT     ,KC_PERC   ,KC_QUES   ,KC_EXLM   ,XXXXXXX   ,_______   ,_______   ,KC_PLUS   ,KC_LCBR   ,KC_RCBR   ,KC_PIPE   ,KC_ASTR   ,\
    ___f___   ,_______   ,_______   ,TO(L_BASE),___f___   ,_______   ,_______   ,___f___   ,___f___   ,_______   ,_______   ,___f___
#define LAYER_NUM \
    KC_QUOT   ,KC_COMM   ,KC_DOT    ,___f___   ,KC_CIRC   ,                      KC_0      ,KC_1      ,KC_2      ,KC_3      ,KC_SLSH   ,\
    m_MINOR   ,m_SFT     ,m_MAJOR   ,m_ALT     ,m_CTL     ,                      KC_MINUS  ,KC_4      ,KC_5      ,KC_6      ,KC_UNDS   ,\
    KC_COLN   ,KC_PERC   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,_______   ,_______   ,KC_PLUS   ,KC_7      ,KC_8      ,KC_9      ,KC_ASTR   ,\
    ___f___   ,_______   ,_______   ,TO(L_BASE),___f___   ,_______   ,_______   ,_______   ,___f___   ,_______   ,_______   ,___f___
#define LAYER_NAV \
    KC_HOME   ,KC_PGUP   ,KC_PGDN   ,KC_END    ,fCOPY     ,                      fCOPY     ,KC_HOME   ,KC_PGUP   ,KC_PGDN   ,KC_END    ,\
    m_MINOR   ,m_SFT     ,m_MAJOR   ,m_ALT     ,fPASTE    ,                      fPASTE    ,KC_LEFT   ,KC_UP     ,KC_DOWN   ,KC_RGHT   ,\
    KC_BTN1   ,KC_BTN2   ,XXXXXXX   ,KC_DEL    ,fCUT      ,KC_MPRV   ,KC_MNXT   ,fCUT      ,KC_DEL    ,KC_INS    ,KC_CAPS   ,KC_SCRL   ,\
    ___f___   ,_______   ,_______   ,TO(L_BASE),___f___   ,KC_MPLY   ,KC_MUTE   ,___f___   ,_______   ,_______   ,_______   ,___f___
#define LAYER_NAV2 \
    C(KC_HOME),C(KC_PGUP),C(KC_PGDN),C(KC_END) ,fCOPY     ,                      fCOPY     ,C(KC_HOME),C(KC_PGUP),C(KC_PGDN),C(KC_END) ,\
    m_MINOR   ,m_SFT     ,m_MAJOR   ,m_ALT     ,fPASTE    ,                      fPASTE    ,C(KC_LEFT),C(KC_UP)  ,C(KC_DOWN),C(KC_RGHT),\
    KC_BTN1   ,KC_BTN2   ,XXXXXXX   ,C(KC_DEL) ,fCUT      ,_______   ,_______   ,fCUT      ,C(KC_DEL) ,KC_INS    ,KC_CAPS   ,KC_SCRL   ,\
    ___f___   ,_______   ,_______   ,TO(L_BASE),C(KC_SPC) ,_______   ,_______   ,C(KC_BSPC),_______   ,_______   ,_______   ,C(KC_ENT)
#define LAYER_FUN \
    KC_F1     ,KC_F2     ,KC_F3     ,KC_F4     ,___f___   ,                      XXXXXXX   ,___f___   ,m_ALT     ,XXXXXXX   ,XXXXXXX   ,\
    KC_F5     ,KC_F6     ,KC_F7     ,KC_F8     ,m_ALT     ,                      m_CTL     ,m_ALT     ,m_MAJOR   ,m_SFT     ,m_MINOR   ,\
    KC_F9     ,KC_F10    ,KC_F11    ,KC_F12    ,XXXXXXX   ,_______   ,_______   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,XXXXXXX   ,\
    ___f___   ,_______   ,_______   ,TO(L_BASE),___f___   ,_______   ,_______   ,___f___   ,___f___   ,_______   ,_______   ,_______
#define LAYER_MOUSE \
    KC_WH_U   ,KC_BTN1   ,KC_MS_U   ,KC_BTN2   ,QK_BOOT   ,                      lGAME     ,KC_BTN1   ,KC_MS_U   ,KC_BTN2   ,KC_WH_U   ,\
    KC_WH_D   ,KC_MS_L   ,KC_MS_D   ,KC_MS_R   ,XXXXXXX   ,                      XXXXXXX   ,KC_MS_L   ,KC_MS_D   ,KC_MS_R   ,KC_WH_D   ,\
    KC_ACL0   ,KC_ACL1   ,KC_ACL2   ,___f___   ,XXXXXXX   ,_______   ,_______   ,XXXXXXX   ,___f___   ,KC_ACL2   ,KC_ACL1   ,KC_ACL0   ,\
    ___f___   ,_______   ,_______   ,TO(L_BASE),___f___   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______
#define LAYER_GAME \
    KC_Q      ,KC_W      ,KC_E      ,KC_R      ,KC_T      ,                      KC_Y      ,KC_U      ,KC_I      ,KC_O      ,KC_P      ,\
    KC_A      ,KC_S      ,KC_D      ,KC_F      ,KC_G      ,                      KC_H      ,KC_J      ,KC_K      ,KC_L      ,KC_SCLN   ,\
    KC_Z      ,KC_X      ,KC_C      ,KC_V      ,KC_B      ,_______   ,_______   ,KC_N      ,KC_M      ,KC_UP     ,KC_DOT    ,KC_SLSH   ,\
    _______   ,m_SFT     ,_______   ,TO(L_BASE),_______   ,_______   ,_______   ,_______   ,KC_LEFT   ,KC_DOWN   ,KC_RGHT   ,_______
#define LAYER_TEMPLATE \
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,                      _______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,\
    _______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______   ,_______

// ensure that tap-then-hold on space bar sends repeated spaces
bool get_tapping_force_hold(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case mKC_SPC:
            return false;
        default:
            return true;
    }
}
