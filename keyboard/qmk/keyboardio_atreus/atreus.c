// 2022 2023 Ruud Wijtvliet

// clang-format off
 
#define PREP_LAYER_FOR_ATREUS(\
               _ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
               _ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
               _ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,_CENTRL1  ,_CENTRR1  ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
               _CORNERL  ,                      _THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1  ,                      _CORNERR  ) \
               \
               _ALPHA01  ,_ALPHA02  ,_ALPHA03  ,_ALPHA04  ,_ALPHA05  ,                      _ALPHA06  ,_ALPHA07  ,_ALPHA08  ,_ALPHA09  ,_ALPHA10  ,\
               _ALPHA11  ,_ALPHA12  ,_ALPHA13  ,_ALPHA14  ,_ALPHA15  ,                      _ALPHA16  ,_ALPHA17  ,_ALPHA18  ,_ALPHA19  ,_ALPHA20  ,\
               _ALPHA21  ,_ALPHA22  ,_ALPHA23  ,_ALPHA24  ,_ALPHA25  ,_CENTRL1  ,_CENTRR1  ,_ALPHA26  ,_ALPHA27  ,_ALPHA28  ,_ALPHA29  ,_ALPHA30  ,\
               _CORNERL  ,XXXXXXX   ,XXXXXXX   ,_THUMBL1  ,_THUMBL2  ,_CENTRL2  ,_CENTRR2  ,_THUMBR2  ,_THUMBR1  ,XXXXXXX   ,XXXXXXX   ,_CORNERR

// clang-format on

#define PREP_LAYER(...) PREP_LAYER_FOR_ATREUS(__VA_ARGS__)
#define EXPAND_LAYOUT(x) LAYOUT(x)

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

void custom_led_indicators(enum supported_os os) {}
void custom_post_init(void) {}
