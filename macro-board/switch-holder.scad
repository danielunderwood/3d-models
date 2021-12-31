// A holder for Cherry MX style switches

module slot(radius=3, width=5) {
    translation = width / 2 - radius;
    hull() {
        translate([-translation, 0]) circle(radius);
        translate([translation, 0]) circle(radius);
    }
}

module switch_bottom() {
    // Various parameters. In reality, these are probably defined in some spec somewhere
    height = 14;
    width = 13;
    peg_radius = 2;
    pin_radius = 1;
    peg_tolerance = 0.5;
    pin1_location = [-4, -2.5];
    pin2_location = [3, -5];
    pin_tolerance = 0.1;

    difference(){
        square([height, width], center=true);
        circle(peg_radius + peg_tolerance);
        translate(pin1_location) circle(pin_radius + pin_tolerance);
        translate(pin2_location) circle(pin_radius + pin_tolerance);
    }
}

bottom_thickness = 1.25;
linear_extrude(bottom_thickness) switch_bottom();
