COMBO_ENABLE = yes
VPATH += keyboards/gboards/

LTO_ENABLE = yes
CONSOLE_ENABLE = no
COMMAND_ENABLE = no
WEBUSB_ENABLE = yes
ORYX_ENABLE = yes

SRC = matrix.c

EXTRAFLAGS += -flto
