#!/bin/bash

title=$1
key=$2
delay=$3

win=$(xdotool search --onlyvisible -name $title | head -1)

xdotool click --clearmodifiers --repeat 100000000000000000 --delay $delay --window $win $key
