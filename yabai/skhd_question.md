# TLDR
**How to define non-alphanumeric keys in SKHD across layouts?**

# Details

## The keyboards and layouts

There are 2 keyboard / layout combinations I'm interested in.
1. Using the internal keyboard, mac layout is set to qwerty.
2. Using the internal keyboard, mac layout is set to dvorak.

## The goal

Now, I want to use SKHD consistently in both situations. Consistently means: I want to define a shortcut by the LABEL that's on the key, not its POSITION in the layout.


## What works as expected

First of all, the easy case: using literal character. This works as expected.
```bash
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
alt - 0x29  : \
    /usr/bin/env osascript <<< "display notification \"Shown when pressing option + the 10th key on the home row, regardless of the character this is on the layout.\" with title \"Triggered by position\""
```
On (1), this triggers on the semicolon key, which is he 10th on the home row.
On (2), this triggers on the 's' key, which is the 10th on the home row.

Apparently, '0x29' is actually linked to the POSITION of the key, not its LABEL. 


**Can I define the semicolon** (and other non-alphanumeric characters) **in SKHD such that they trigger on every layout that might be selected?**

# # # Background info, uncessary
# # 3. Using an external keyboard which has dvorak layout but "pretends to be a qwerty" (*), mac layout is set to qwerty. 
# #
# (*) This sounds weird but is actually the most common way to configure programmable keyboards, and how it's done in "industry-standard" software like QMK or ZSA's Onyx. It makes sense from the persective that a programmable keyboard can have ANY layout, including non-standard ones. Let's not discuss this point, please.
# # 
# I normally use the dvorak layout, so I'm especially interested in (2) and (3), which work identically. Presses at the same position output the same key, e.g., the 4th key on the home row outputs U.
# Sometimes, another person might use my laptop, they will be using (1). The 4th key on the home row outputs F; U is output by the 7th key on the top row.
