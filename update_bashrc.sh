#!/bin/bash

# Path to your .bashrc file
BASHRC="$HOME/.bashrc"

# Function to safely comment out lines matching a pattern
comment_out() {
    local pattern="$1"
    if grep -qE "$pattern" "$BASHRC"; then
        sed -i "s|^\($pattern\)|#\1|" "$BASHRC"
    fi
}

# Function to safely add a line to .bashrc if it doesn't exist
add_line() {
    local line="$1"
    if ! grep -Fxq "$line" "$BASHRC"; then
        echo "$line" >> "$BASHRC"
    fi
}

# Function to remove a block of lines between two patterns
remove_block() {
    local start_pattern="$1"
    local end_pattern="$2"
    sed -i "/$start_pattern/,/$end_pattern/d" "$BASHRC"
}

# Change export EDITOR and VISUAL
sed -i 's/export EDITOR=nvim/export EDITOR=vim/' "$BASHRC"
sed -i 's/export VISUAL=nvim/export VISUAL=vim/' "$BASHRC"

# Comment out specific alias lines
comment_out "alias vim='nvim'"
comment_out "alias vi='nvim'"
comment_out "alias vis='nvim \"+set si\"'"

# Add new aliases to the section for modified commands
add_line "alias pas='pacman -Ss'"
add_line "alias yas='yay -Ss'"
add_line "alias cat='bat'"

# Add source command at the very bottom of the .bashrc file
add_line "source ~/.local/share/blesh/ble.sh"

# Remove the specified block of lines
remove_block 'DISTRIBUTION=\$(distribution)' 'fi'

echo ".bashrc has been updated."

