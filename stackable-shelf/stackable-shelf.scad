epsilon = 0.1;

module hole(hole_depth, hole_radius, hole_sides) {
    linear_extrude(hole_depth + epsilon) circle(r=hole_radius, $fn=hole_sides)  ;
}

module shelf(height=100, width=100, thickness=5, hole_inset=5, hole_depth=3, hole_radius=3, hole_sides=6) {
    difference() {
        cube([height, width, thickness]);
        translate([hole_inset + hole_radius, hole_inset + hole_radius, thickness - hole_depth]) hole(hole_depth, hole_radius, hole_sides);
        translate([height - hole_inset - hole_radius, hole_inset + hole_radius, thickness - hole_depth]) hole(hole_depth, hole_radius, hole_sides);
        translate([hole_inset + hole_radius, width - hole_inset - hole_radius, thickness - hole_depth]) hole(hole_depth, hole_radius, hole_sides);
        translate([height- hole_inset - hole_radius, width - hole_inset - hole_radius, thickness - hole_depth]) hole(hole_depth, hole_radius, hole_sides);
    }
}

module support(height=100, hole_radius=3, hole_sides=6, tolerance=0.1) {
    linear_extrude(height) circle(r=hole_radius - tolerance, $fn=hole_sides);
}

// Parameters
height = 90;
inner_width = 90;
inner_depth = 140;
thickness = 10;
hole_depth = 7;
hole_radius = 5;
hole_inset = 5;

width = inner_width + 2 * (hole_inset + hole_radius);
depth = inner_depth + 2 * (hole_inset + hole_radius);

// This will give something like a bevel without much work
minkowski() {
    shelf(height=depth, width=width, thickness=thickness, hole_radius=hole_radius, hole_depth=hole_depth, hole_inset=hole_inset);
    sphere(1);
}
translate([150, 150, 0]) support(height=height + 2 * hole_depth, hole_radius=hole_radius);