epsilon = 0.1;

module circular_clip_base(
    base_radius=16,
    base_thickness=5,
    wall_height=19,
    outer_radius=9.25,
    inner_radius = 7.5,
    clip_radius = 1.25
    ) {

        // Base shape
        difference() {
            union() {
                cylinder(base_thickness, base_radius, base_radius);
                translate([0, 0, base_thickness]) {
                    cylinder(wall_height, outer_radius, outer_radius);
                }
                // Clippy bits
                translate([0, 0, wall_height]) {
                    ring(outer_radius, outer_radius + clip_radius);
                }
            }
            translate([0, 0, -epsilon]) {
                cylinder(base_thickness + wall_height + 2 * epsilon, inner_radius, inner_radius);
            }
        }
}

module circular_clip_cut(
        base_radius=16,
        base_thickness=5,
        wall_height=19,
        outer_radius=9.25,
        inner_radius = 7.5,
        cut_width=3,
        cut_interval=60,
        clip_radius=1.25
    ) {
        // Cut out slots to create clips that have flexibility
        difference() {
            circular_clip_base(
                base_radius,
                base_thickness,
                wall_height,
                outer_radius,
                inner_radius,
                clip_radius
            );
            union() {
                for (i = [0:cut_interval:180 - cut_interval]) {
                    rotate([0, 0, i]){
                        translate([-(outer_radius + clip_radius), 0, base_thickness + epsilon]) {
                            cube([(outer_radius + clip_radius) * 2, cut_width, wall_height + epsilon]);
                        }
                    }
                }
            }
        }
}

module ring(inner_radius, outer_radius) {
    rotate_extrude(angle=360) {
        translate([inner_radius, 0]) {
            circle(outer_radius - inner_radius);
        }
    }
}

module circular_clip(
        base_radius=16,
        base_thickness=5,
        wall_height=19,
        outer_radius=9.25,
        inner_radius = 7.5,
        cut_width=3,
        cut_interval=60,
        clip_radius=1.25
    ) {
        circular_clip_cut(
            base_radius,
            base_thickness,
            wall_height,
            outer_radius,
            inner_radius,
            cut_width,
            cut_interval,
            clip_radius
        );
}

// Add some smoothing. Note that this operation takes quite some time to compute,
// so you may want to disable it while developing the model
minkowski() {
    circular_clip();
    sphere(0.5);
}