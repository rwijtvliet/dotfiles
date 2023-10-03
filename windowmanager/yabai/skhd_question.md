Defining non-alphanumeric characters based on symbol, not location

This question is phrased for SKHD, but it applies more generally.

# TLDR

**How to define non-alphanumeric keys in SKHD across layouts?**

# Details

## The keyboards and layouts

There are 2 keyboard / layout combinations I'm interested in.

1. Using the internal keyboard, layout is set to qwerty.
2. Using the internal keyboard, layout is set to dvorak.

## The goal

I want to use SKHD consistently in both situations. Consistently means: I want to define a shortcut by the LABEL that's on the key, not its POSITION in the layout.

## What works as expected

First of all, the easy case: using literal character. This works as expected.

```bash
# skhdrc
alt - u  : \
    /usr/bin/env osascript <<< "display notification \"Shown when pressing option-U, regardless of where it is on the layout.\" with title \"Triggered by character\""
```

On (1), this triggers on the 'u' key, which is the 7th on the top row.
On (2), this triggers on the 'u' key, which is the 4th on the home row.
So, it's always triggered on the 'u' key, wherever it might be.

So far, so good.

## What does not work

The problems start when trying to use non-alphanumeric characters, such as the semicolon. Its keycode is 0x29 and we're advised to use it. However, it has an unintended effect.

```bash
# skhdrc
alt - 0x29  : \
    /usr/bin/env osascript <<< "display notification \"Shown when pressing option + the 10th key on the home row, regardless of the character this is on the layout.\" with title \"Triggered by position\""
```

On (1), this triggers on the semicolon key, which is he 10th on the home row.
On (2), this triggers on the 's' key, which is the 10th on the home row.

Apparently, '0x29' is actually linked to the POSITION of the key, not its LABEL.

## Therefore, the question:

**How can I define the semicolon** (and other non-alphanumeric characters) **in SKHD such that it triggers on every layout that might be selected?**
