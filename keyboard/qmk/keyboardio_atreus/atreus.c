// Copyright (C) 2019 ,2020  Keyboard.io ,Inc
//
// Ruud Wijtvliet
//
// good tutorial:
// https://precondition.github.io/home-row-mods

#define EXPAND_LAYOUT(x) LAYOUT(x)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [L_BASE] = EXPAND_LAYOUT(LAYER_BASE),
    [L_BASE2] = EXPAND_LAYOUT(LAYER_BASE2),
    [L_SYM] = EXPAND_LAYOUT(LAYER_SYM),
    [L_NUM] = EXPAND_LAYOUT(LAYER_NUM),
    [L_NAV] = EXPAND_LAYOUT(LAYER_NAV),
    [L_NAV2] = EXPAND_LAYOUT(LAYER_NAV2),
    [L_FUN] = EXPAND_LAYOUT(LAYER_FUN),
    [L_MOUSE] = EXPAND_LAYOUT(LAYER_MOUSE),
    [L_GAME] = EXPAND_LAYOUT(LAYER_GAME),
};

void led_indicators(enum supported_os os) { // called by keymap_partial.c
}