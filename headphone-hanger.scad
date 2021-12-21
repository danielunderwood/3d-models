include <desk.scad>;

clip_thickness = 5;
clip_height = 30;

support_thickness = 8;
support_height = 30;

connector_height = 10;

module headphone_holder() {
    union() {
        rail_cutout();
        // Mounting surface for external accesory
        translate([-outer_width / 2 - 1.5 * thickness - epsilon, -outer_height / 2]) {
            square([clip_thickness, clip_height]);
        }
        color("blue") translate([outer_width / 2, -outer_height / 4]) {
            square([support_thickness, support_height]);
        }

        color("green") {
            translate([-(outer_width + thickness / 2 + clip_thickness) / 2, -outer_height / 2 - connector_height]) {
                square([outer_width + thickness + clip_thickness + support_thickness, connector_height]);
            }
            translate([outer_width / 2 + clip_thickness / 2, -outer_height / 2]) {
                square([support_thickness, outer_height / 2]);
            }
        }
    }
}

linear_extrude(8) headphone_holder();