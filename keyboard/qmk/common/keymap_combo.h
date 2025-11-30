#pragma once
#include "quantum.h"
#include "process_combo.h"

// --- First pass: generate combo arrays ---
#define COMB(name, result, ...) \
    const uint16_t PROGMEM name##_combo[] = { __VA_ARGS__, COMBO_END };

#include "combos.def"

// --- Second pass: build enum of combo names ---
#undef COMB
#define COMB(name, result, ...) name,

enum combo_names {
    #include "combos.def"
};

// --- Third pass: build single key_combos array ---
#undef COMB
#define COMB(name, result, ...) [name] = COMBO(name##_combo, result),

combo_t key_combos[] = {
    #include "combos.def"
};
