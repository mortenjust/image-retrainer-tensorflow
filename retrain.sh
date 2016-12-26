# Retrains the inception model with the provided images
# Run from project root

PROJECT_ROOT=$(pwd)
LARGE_IMAGES=$PROJECT_ROOT/training-images-large
SMALL_IMAGES=$PROJECT_ROOT/training-images-small
TENSORFLOW=~/code/tensorflow

~/code/tensorflow/bazel-bin/tensorflow/examples/image_retraining/retrain --image_dir $SMALL_IMAGES

cd $TENSORFLOW

touch WORKSPACE

# bazel build tensorflow/python/tools:strip_unused && \ # RUN FIRST TIME
bazel-bin/tensorflow/python/tools/strip_unused \
--input_graph=/tmp/output_graph.pb \
--output_graph=/tmp/output_graph_stripped.pb \
--input_node_names=Mul \
--output_node_names=final_result \
--input_binary=true

cd $PROJECT_ROOT

open -R /tmp/output_graph_stripped.pb