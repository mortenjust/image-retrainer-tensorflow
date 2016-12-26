#Retrainer

## Requirements
* Clone of Tensorflow repository
* Imagemagick available in path
* Bazel available in path

## Installation
* Go through <a href="https://www.tensorflow.org/how_tos/image_retraining/">this tutorial</a> once to get the necessary builds
* From your tensorflow repo's root folder, build the unused tags stripper `bazel build tensorflow/python/tools:strip_unused`
* In each script, edit the `$TENSORFLOW` variable to mach your Tensorflow repository path 

## Running the script 
1. Record videos of each device you want to train the model with
1. Put these scripts in the root of your project folder
1. Put the videos in a new folder, `videos/`
1. In your project root (not tensorflow root), create the folders `training-images-large` and `training-images-small`
1. Rename the videos from `yourvideo.mov` to `your-label-name.mov`
1. cd `your/project/folder`
1. Run `video-to-model.sh`

## Using the model
1. When the script ends you will have these files in `/tmp`
    * `output_graph_stripped.pb` is the Tensorflow model that is ready to use, with e.g. Tensorflow's iOS sample
    * `output_labels.txt` is all the labels. One per video. 
    * `output_graph.pb` is the model before stripping unused tags. Using this will give you an error in the iOS sample.
    * `bottleneck` is a cache that will speed up subsequent retraining sessions. Delete these files if you switch out your already trained videos.
    * `retrain-logs/` contains your logs. You can use Tensorboard to analyze your model while and after it learns. 
1. Copy `output_graph_stripped.pb` and `output_labels.txt` files to your project
1. In your code, use something like
    * `static NSString* model_file_name = @"output_graph_stripped";`
    * `static NSString* labels_file_name = @"output_labels";`
1. Names for input and output layers are `Mul` and `final_result:0`. In the Objective-C iOS sample that would be something like
    * `const std::string input_layer_name = "Mul";`
    * `const std::string output_layer_name = "final_result:0";`

## Running each script individually
If you need new source data for individual labels, you can save time by running the scripts individually

Examples:
* `extract-from-video.sh /path/to/video.MOV` extracts frames from video. You can change the FPS rate in the script.
* `extract-all-videos.sh` takes all files in `videos/` and runs `extract-from-video.sh` on them
* `resize.sh dandelion` resizes all images in `training-images-large/dandelion` and puts the smaller images in `training-images-small/dandelion`. Default size is max 200 pixels on either side, and you can change that value in this script. 
* `retrain.sh` retrains the perception model with the images in the `training-images-small` folder. It also strips unused tags from the model. 

## TODO - contributions welcome
See TODO file 