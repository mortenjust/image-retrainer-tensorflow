$FRAME_RATE=10

# grab video file name from $1

# extract each frame into the label folder named $1 (sans extension)

#!/bin/bash

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: don't forget to specify a video path'"
  exit 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments, you' talkin too much"
  exit 2
fi

PROJECT_ROOT=$(pwd)
LARGE_IMAGES=$PROJECT_ROOT/training-images-large
SMALL_IMAGES=$PROJECT_ROOT/training-images-small
VIDEO=$1

# grab label from filename - /folder/folder/label-name.MOV = label-name
filename=$(basename "$VIDEO")
extension="${filename##*.}"
filename="${filename%.*}"
LABEL=$filename

echo Small images: $SMALL_IMAGES/$LABEL
echo Large images: $LARGE_IMAGES/$LABEL
echo Label: $LABEL

# create label dir if it does not exist
mkdir -p $LARGE_IMAGES/$LABEL

# 1fps is too low a framerate 
# ffmpeg -i "$VIDEO" -r 1/1 "$LARGE_IMAGES/$LABEL/$LABEL%03d.jpg"

# higher quality, $FRAME_RATE fps
ffmpeg -i "$VIDEO" -r 5 -qscale:v 2 $LARGE_IMAGES/$LABEL/$LABEL%03d.jpg