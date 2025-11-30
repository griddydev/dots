#!/bin/bash

nupdates=$(checkupdates | wc -l)
icon=""

printf " %s%s \\n" "$icon " "$nupdates"

