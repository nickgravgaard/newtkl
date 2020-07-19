#!/bin/bash

LAYOUT_NAME=newtkl

# Set QMK_PATH before calling, eg: `QMK_PATH=~/code/qmk_firmware ./build.sh`
DEST_PATH=${QMK_PATH}/keyboards/massdrop/ctrl/keymaps/${LAYOUT_NAME}
rm -rf $DEST_PATH
mkdir -p $DEST_PATH

# Copy files to new dir in QMK's keymaps directory
cp keymap.c $DEST_PATH
cp rules.mk $DEST_PATH

# cd to qmk_firmware directory
cd $QMK_PATH
# Compile a bin file in this directory
make massdrop/ctrl:${LAYOUT_NAME}
cd -

BIN_FILE=${QMK_PATH}/.build/massdrop_ctrl_${LAYOUT_NAME}.bin

printf "\nWhen mdloader scans for the device, hold Fn + b for half a second and release to reset the keyboard (the LEDs will turn off). If this doesn't work, use a pin to press the reset button through the hole in the bottom of the keyboard.\n"

sudo ./mdloader_linux --first --download ${BIN_FILE} --restart

