echo -----------
echo resize-all-and-train.sh
echo -----------




PROJECT_ROOT=$(pwd)
VIDEO_FOLDER=$PROJECT_ROOT/videos
LARGE_IMAGES=$PROJECT_ROOT/training-images-large
SMALL_IMAGES=$PROJECT_ROOT/training-images-small

# STEP 1 - RESIZE all images in all folders

shopt -s nullglob   # empty directory will return empty list
for dir in $LARGE_IMAGES/*/;do
    
    LABEL=$(basename $dir)
    echo "Resizing label $LABEL"
    ./resize.sh $LABEL
done

# back to the videos to get all labels using the video names MINUS the extension MINUS the trailing -00 part
# for LABEL in /$LARGE_IMAGES/W*
# do 
#     # filename=$(basename "$VIDEO")
#     # extension="${filename##*.}"
#     # filename="${filename%.*}"
#     # # LABEL=$filename
#     # LABEL=${filename%-[0-9]*.*} # strip the -01 part 

#     echo "resizing label: $LABEL"
#     # ./resize.sh $LABEL # resizes all files in 
# done


# STEP 3 - RETRAIN THE INCEPTION MODEL'S FINAL LAYER

./retrain.sh


# STEP 4 - move the model into the project bundle: /tmp/output_graph_stripped.pb and /tmp/output_labels.txt