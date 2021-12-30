// Include this file to make pegstr accomodate my pegboard
include <../pegstr/pegstr.scad>

// Note that my board seems to be a bit abnormal
board_thickness = 6;

holder_y_count = 1;

// Because we changed hidden parameters, these need to be recalculated
clip_height = 2*hole_size + 2;