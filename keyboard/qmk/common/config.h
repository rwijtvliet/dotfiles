

// Configure the global tapping term (default: 200ms)
#undef TAPPING_TERM
#define TAPPING_TERM 175

// Prevent normal rollover on alphas from accidentally triggering mods.
// Important setting.
// #define IGNORE_MOD_TAP_INTERRUPT // is now (2023) standard so this line can
// (must) be excluded

// Enable rapid switch from tap to hold, disables double tap hold auto-repeat.
#define TAPPING_FORCE_HOLD_PER_KEY

// COMBOS
#define COMBO_TERM 30
#define COMBO_ONLY_FROM_LAYER 1 // from base2
#define COMBO_VARIABLE_LEN

// mouse movements
#define MK_COMBINED

// #define LEADER_PER_KEY_TIMING
// #define LEADER_TIMEOUT 250

#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

#define ONESHOT_TAP_TOGGLE                                                     \
  5 /* Tapping this number of times holds the key until tapped once again. */
#define ONESHOT_TIMEOUT                                                        \
  5000 /* Time (in ms) before the one shot key is released */
