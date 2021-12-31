// A holder for Cherry MX style switches

module slot(radius=3, width=5) {
    translation = width / 2 - radius;
    hull() {
        translate([-translation, 0]) circle(radius);
        translate([translation, 0]) circle(radius);
    }
}

module switch_bottom_single() {
    // Various parameters. In reality, these are probably defined in some spec somewhere
    height = 14;
    width = 15;
    peg_radius = 2;
    pin_radius = 1;
    peg_tolerance = 0.5;
    pin1_location = [-4, -2.5];
    pin2_location = [3, -5];
    pin_tolerance = 0.1;

    difference(){
        square([height, width], center=true);
        hull(){
        circle(peg_radius + peg_tolerance, $fn=20);
        translate(pin1_location) circle(pin_radius + pin_tolerance,$fn=10);
        translate(pin2_location) circle(pin_radius + pin_tolerance, $fn=10);
        }
    }
}

module switch_bottom_multi() {
    // Various parameters. In reality, these are probably defined in some spec somewhere
    height = 14;
    width = 15;
    peg_radius = 2;
    pin_radius = 1;
    peg_tolerance = 0.5;
    pin1_location = [-4, -2.5];
    pin2_location = [3, -5];
    pin_tolerance = 0.1;

    difference(){
        square([height, width], center=true);{
        circle(peg_radius + peg_tolerance, $fn=20);
        translate(pin1_location) circle(pin_radius + pin_tolerance,$fn=10);
        translate(pin2_location) circle(pin_radius + pin_tolerance, $fn=10);}
    }
}

bottom_thickness = 1.5;
holder_width = 20;
holder_height = 20;
wall_height = 10;
holder_thickness = 1;
epsilon = 0.1;



linear_extrude(bottom_thickness) {
    union() {
        switch_bottom_single();
        translate([holder_width, 0]) switch_bottom_multi();
        // Join the shapes. This isn't great, but it works I guess
        translate([holder_width  / 2, 0]) square([14 / 2, 15], center=true);
    }

}