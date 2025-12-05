#!/bin/bash

/usr/bin/clipman pick --print0 --tool=CUSTOM --tool-args="/usr/bin/fzf --prompt 'Clipboard > ' --read0 --no-sort --layout=reverse --height=10 --border --bind 'k:up,j:down,q:abort'"
