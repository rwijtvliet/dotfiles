/*
  Set any config.h overrides for your specific keymap here.
  See config.h options at
  https://docs.qmk.fm/#/config_options?id=the-configh-file
*/
#undef TAPPING_TERM
#define TAPPING_TERM 175
// COMBOS
#define COMBO_TERM 30
#define COMBO_ONLY_FROM_LAYER 1 // from base2
#define COMBO_VARIABLE_LEN

#define USB_SUSPEND_WAKEUP_DELAY 0
#define IGNORE_MOD_TAP_INTERRUPT
#define FIRMWARE_VERSION u8"wGKrV/pVKvD"
#define RAW_USAGE_PAGE 0xFF60
#define RAW_USAGE_ID 0x61
#define LAYER_STATE_16BIT

#define RGB_MATRIX_STARTUP_SPD 60

#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

#define ONESHOT_TAP_TOGGLE                                                     \
  5 /* Tapping this number of times holds the key until tapped once again. */
#define ONESHOT_TIMEOUT                                                        \
  5000 /* Time (in ms) before the one shot key is released */
