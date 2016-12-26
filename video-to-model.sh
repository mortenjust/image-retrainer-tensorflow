
PROJECT_ROOT=$(pwd)
VIDEO_FOLDER=$PROJECT_ROOT/videos
LARGE_IMAGES=$PROJECT_ROOT/training-images-large
SMALL_IMAGES=$PROJECT_ROOT/training-images-small


# STEP 1 - EXTRACT FRAMES FROM VIDEO

./extract-all-videos.sh

# STEP 2 - RESIZE FRAMES TO 200 PIXELS

# get all labels using the video names
for VIDEO in $VIDEO_FOLDER/*
do 
    filename=$(basename "$VIDEO")
    extension="${filename##*.}"
    filename="${filename%.*}"
    LABEL=$filename

    echo "resizing label: $LABEL"
    ./resize.sh $LABEL
done


# STEP 3 - RETRAIN THE INCEPTION MODEL'S TOP LAYERS

./retrain.sh


# STEP 4 - move the model into the project bundle: /tmp/output_graph_stripped.pb and /tmp/output_labels.txt