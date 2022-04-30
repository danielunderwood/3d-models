base_width = 120;
base_depth = 150;
base_thickness = 5;
holder_thickness = 5;
holder_height = 80;
holder_spacing = 40;

module base() {
    minkowski() {
        cube([base_width, base_depth, base_thickness]);
        cylinder(base_thickness, 5, 5);
    }
}

module holder() {
    minkowski() {
        cube([holder_thickness, base_depth, holder_height]);
        cylinder(base_thickness, 5, 5);
    }
}

base();
for (offset = [0:holder_spacing:base_width]) {
    translate([offset, 0, 0]) holder();
}
