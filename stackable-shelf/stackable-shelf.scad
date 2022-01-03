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
thickness = 6;
hole_depth = 0.75 * thickness;
hole_radius = 5;
hole_inset = 5;

width = inner_width + 2 * (hole_inset + hole_radius);
depth = inner_depth + 2 * (hole_inset + hole_radius);

module hexagon_grid(rows=5, cols=5, radius=5, spacing=5) {
    total_spacing = spacing + radius;
    for (row = [0:rows-1]) {
        for (col = [0:cols-1]) {
            // Offset the columns for odd rows to pack hexagons
            col_offset = row % 2 == 0 ? 0 : total_spacing / 2;
            translate([total_spacing * row, total_spacing * col + col_offset]) circle(radius, $fn=6);
        }
    }
}

grid_rows = 10;
grid_cols = 5;
grid_spacing = 7;
grid_radius = 6;
// FIXME I have no idea why these values work. They don't make any sense, but it
// gets us close to the right positioning with these parameters
grid_width = grid_cols * (2 * grid_radius);
grid_height = grid_rows * (grid_radius) - (grid_rows - 2) * grid_spacing/4;

difference() {
    shelf(height=depth,
        width=width,
        thickness=thickness,
        hole_radius=hole_radius,
        hole_depth=hole_depth,
        hole_inset=hole_inset);
    translate([(height - grid_height)/ 2 , (width- grid_width) / 2, -epsilon]) {
        linear_extrude(thickness + 2*epsilon) {
            hexagon_grid(rows=grid_rows,
                        cols=grid_cols,
                        spacing=grid_spacing,
                        radius=grid_radius);
        }
    }
}
translate([150, 150, 0]) support(height=height + 2 * hole_depth, hole_radius=hole_radius, tolerance=0.25);