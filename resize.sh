#!/bin/bash

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: don't forget to specify a label'"
  exit 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments, you' talkin too much"
  exit 2
fi

PROJECT_ROOT=$(pwd)
LARGE_IMAGES=$PROJECT_ROOT/training-images-large
SMALL_IMAGES=$PROJECT_ROOT/training-images-small
LABEL=$1

echo Small images: $SMALL_IMAGES/$LABEL
echo Large images: $LARGE_IMAGES/$LABEL

mkdir -p $SMALL_IMAGES/$LABEL

# remove files in the label folder for small images
rm $SMALL_IMAGES/$LABEL/small-*.JPG 2> /dev/null
rm $SMALL_IMAGES/$LABEL/small-*.jpeg 2> /dev/null
rm $SMALL_IMAGES/$LABEL/small-*.jpg 2> /dev/null

# resize all images in the large folder for this label
for file in $LARGE_IMAGES/$LABEL/*.JPG $LARGE_IMAGES/$LABEL/*.jpg $LARGE_IMAGES/$LABEL/*.jpeg
do 
    echo Resizing $(basename $file)
    convert "$file" -resize 200 "$SMALL_IMAGES/$LABEL/small-$(basename $file)"
done

