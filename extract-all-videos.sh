# grab video file name from $1

# extract each frame into the label folder named $1 (sans extension)

#!/bin/bash

PROJECT_ROOT=$(pwd)
VIDEO_FOLDER=$PROJECT_ROOT/videos
LARGE_IMAGES=$PROJECT_ROOT/training-images-large
SMALL_IMAGES=$PROJECT_ROOT/training-images-small

# TODO LABEL=

# resize all images in the large folder for this label
for VIDEO in $VIDEO_FOLDER/*
do  
    filename=$(basename "$VIDEO")
    extension="${filename##*.}"
    filename="${filename%.*}"

    LABEL=$filename
    
    ./extract-from-video.sh $VIDEO 

# this is moved to extract-from-video.sh

    # echo extracting from $(basename $VIDEO)

    # echo Small images: $SMALL_IMAGES/$LABEL
    # echo Large images: $LARGE_IMAGES/$LABEL
    # echo Label: $LABEL

    # mkdir -p $LARGE_IMAGES/$LABEL

    # ffmpeg -i "$VIDEO" -r 5 "$LARGE_IMAGES/$LABEL/$LABEL%03d.jpg"
done