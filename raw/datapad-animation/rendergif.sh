#!/bin/sh

ffmpeg -i p_%04d.png -vf palettegen palette.png
ffmpeg -i p_%04d.png -i palette.png -lavfi "paletteuse" datapad-animation.gif
