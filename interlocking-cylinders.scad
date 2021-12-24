epsilon = 0.01;

module cylinder_with_base(
    base_radius,
    base_thickness,
    outer_radius,
    inner_radius,
    wall_height
){
    difference() {
        union() {
            cylinder(base_thickness, base_radius, base_radius);
            translate([0, 0, base_thickness]) {
                cylinder(wall_height, outer_radius, outer_radius);
            }
        }
        translate([0, 0, -epsilon]) {
            cylinder(
                base_thickness + wall_height + 2 * epsilon,
                inner_radius,
                inner_radius
            );
        }
    }
}

base_radius = 16;
base_thickness = 5;
outer_radius = 9.25;
wall_height = 19;
// Each wall, not combined
wall_thickness = 2;

translate([1.5 * base_radius, 0, 0]) {
    cylinder_with_base(
        base_radius = base_radius,
        outer_radius = outer_radius,
        inner_radius = outer_radius - wall_thickness,
        base_thickness = base_thickness,
        wall_height = wall_height
    );
}

translate([-1.5 * base_radius, 0, 0]) {
    cylinder_with_base(
        base_radius = base_radius,
        outer_radius = outer_radius - wall_thickness,
        inner_radius = outer_radius - 2 * wall_thickness,
        base_thickness = base_thickness,
        wall_height = wall_height
    );
}