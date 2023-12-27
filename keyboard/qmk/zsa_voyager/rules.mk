# Set any rules.mk overrides for your specific keymap here.
# See rules at https://docs.qmk.fm/#/config_options?id=the-rulesmk-file
COMBOS_ENABLE = yes
VPATH += keyboards/gboards

OS_DETECTION_ENABLE = yes
CONSOLE_ENABLE = yes

COMMAND_ENABLE = no
MOUSEKEY_ENABLE = no
ORYX_ENABLE = yes
RGB_MATRIX_CUSTOM_KB = no
TAP_DANCE_ENABLE = no
SPACE_CADET_ENABLE = no
CAPS_WORD_ENABLE = yes

PROGRAM_CMD = $(call EXEC_DFU)
DFU_ARGS = -d 3297:0791 -a 0 -s 0x08002000:leave
	
SRC = matrix.c
