#!/bin/bash

set -ex

TERMINFO_DIR=/usr/local/share/terminfo

# Copy terminfo data to /usr/local/share/terminfo (writable on immutable OSes)
mkdir -p "${TERMINFO_DIR}"
cp -r usr/share/terminfo/. "${TERMINFO_DIR}/"

# Set TERMINFO_DIRS so ncurses finds the terminfo files
if ! grep -q '^TERMINFO_DIRS=' /etc/environment 2>/dev/null; then
    echo "TERMINFO_DIRS=${TERMINFO_DIR}" >> /etc/environment
fi

echo "terminfo installed successfully"
