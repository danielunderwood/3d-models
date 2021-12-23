include <desk.scad>;

clip_thickness = 5;
clip_height = 30;

support_thickness = 8;
support_height = 30;

connector_height = 10;

// Where headphones actually go
mount_thickness = 42.5;
mount_height = 5;

module headphone_holder() {
    difference(){
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
                translate([-(outer_width + thickness / 2 + 1.5*clip_thickness) / 2, -outer_height / 2 - connector_height]) {
                    square([outer_width + thickness + clip_thickness + support_thickness, connector_height]);
                }
                translate([outer_width / 2 + 1.5*clip_thickness / 2, -outer_height / 2]) {
                    square([support_thickness, outer_height / 2]);
                }
            }

            color("red") {
                // Piece to hold headphone band
                translate([-outer_width / 2 - 1.5 * thickness - epsilon - mount_thickness,
                           -outer_height / 2  + clip_height / 2]) {
                    square([mount_thickness, mount_height]);
                }
                // Lip to make sure headphone band doesn't fall off
                translate([-outer_width / 2 - 1.5 * thickness - epsilon - mount_thickness, 
                           -outer_height / 2  + clip_height / 2 + mount_height]) {
                    square([clip_thickness, clip_height / 4]);
                }
            }
        }
        // Cut off top half in attempt to mount with only lower
        translate(([-50, 0])) square(100);
    }
}

linear_extrude(15) headphone_holder();