include <../pegstr/pegstr.scad>


// Note that my board seems to be a bit abnormal
board_thickness = 6;
hole_spacing = 19.19;

holder_y_count = 1;

// Because we changed hidden parameters, these need to be recalculated
clip_height = 2*hole_size + 2;

plate_x = 10;
plate_y = 10;
holder_length = 50;
plate_thickness = 3;

// Offset of plate to make it flush with board
plate_offset = 2;

// Offset of holder to make sure there's not a hole from the angle
holder_offset = 1;

// Angle to keep things on the surface
angle = 20;

module holder() {
    union() {
        pin(true);
        translate([0, 0, -board_thickness + plate_thickness/2 + plate_offset])  {
            // Plate to hold against pegboard surface
            cube([plate_x, plate_y, plate_thickness], center=true);
            translate([-holder_length * sin(angle), 0, -holder_length + holder_offset]) {
                rotate([0, angle, 0]) cylinder(holder_length + holder_offset, hole_size / 2, hole_size / 2);
            }
        }
    }
}

// Flatten sides of model so it can print without supports

// Size big compared to model
// TODO Actually calculate from parameters
big = 1000;

// Thickness to cut
// This should give flat sides for printability, but not be much
//  smaller than the pegboard's hole diameter
thickness = 5;
intersection() {
    cube([big, thickness, big], center=true);
    holder();
}