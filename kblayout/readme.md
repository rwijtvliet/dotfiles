Custom keyboard layout.

# Why

We need a keyboard layout without dead keys, in order to use every ALT (=Option) + key combination.

# How

## 1. Make the layouts

This is already done in the `./undead.bundle/` folder.

If the files are incorrect, they can be recreated with ukelele.

## 2. Make available

Copy the `*.keylayout` files to `~/Library/Keyboard Layouts/`. This is done by the install script.

Probably a reboot is necessary. Then they must be added to the input selection list (click "open keyboard settings", search for "undead"). The entries "Dvorak undead" and "US undead" should now be selectable from the list.

## 3. Make scripts that can change selected layout to a *specific* one

This is already done, the output are the `./set_us_undead` and `./set_dvorak_undead` files.

If the files do not work (try by executing them), they can be recreated with `clang -framework Carbon whatever.m -o whatever`. See [this question](https://stackoverflow.com/a/63232278/2302262).

## 4. Ensure the scripts are run when the correct key is pressed

This is already done, by setting a keyboard shortcut in `skhdrc`. 

We use alt + cmd + f1 for dvorak, and alt + cmd + f2 for US.





