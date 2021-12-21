thickness = 3;
outer_height = 60;
inner_height = outer_height - 2 * thickness;
inner_width = 16;
outer_width = inner_width + 2 * thickness;
cutout_height = 42;
epsilon = 0.01;

// Cross-section of rail that goes underneath desk
module desk_cross_section() {
    difference() {
        square([outer_width, outer_height], center=true);
        square([inner_width, inner_height], center=true);
        translate([inner_width / 2 - epsilon, -cutout_height / 2, 0]) {
            square([thickness + 2*epsilon, cutout_height]);
        }
    }
}

// Creates a rail-mountable cutout
module rail_cutout(tolerance=0.1) {
    difference() {
        square([outer_width - epsilon, outer_height - epsilon], center=true);
        desk_cross_section();
    }
}
      