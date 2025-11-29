#!/usr/bin/env bash

printf "'%s' " "$@"

j4-dmenu-desktop --dmenu "$(printf "'%s' " "$@")" --term alacritty
