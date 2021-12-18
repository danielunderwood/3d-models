// Shelf to mount power brick under desk

width = 180;
depth = 180;
height = 15;

// Channel for lip under desk
channel_inset = 12;
channel_width = 5;
channel_height = 10;

// Cutout for extra space while still leaving channels supported
cutout_height = channel_height;
cutout_inset = channel_inset;

// For making sure things are properly cut out
epsilon = 0.1;

// Cutouts to reduce material and provide airflow
holes_radius = 7;
holes_offset = channel_inset + channel_width + cutout_inset + holes_radius;
holes_spacing = 18;

// Thanks https://gist.github.com/lorennorman/1534990
module hexagon(radius)
{
  circle(r=radius,$fn=6);
}

module hexagon_lattice(rows, cols, row_spacing, col_spacing, height, radius) {
    union() {
        for (row = [0:1:rows]) {
            for(col = [0:1:cols]) {
                col_offset = row % 2 == 0 ? radius : 0;
                translate([row * (row_spacing), col * (col_spacing) + col_offset, 0]) {
                    linear_extrude(height) hexagon(radius);
                }
            }
        }
    }
}

difference() {
    cube([width, depth, height]);
    // Various cutouts
    union() {
        // Channels
        translate([channel_inset, -epsilon, -epsilon]) {
            cube([channel_width, depth + 2*epsilon, channel_height]);
        }
        translate([-epsilon,  channel_inset, -epsilon]) {
            cube([depth + 2 * epsilon, channel_width, channel_height]);
        }
        // Cutout for extra space and to reduce materials
        translate([channel_inset + cutout_inset, channel_inset + cutout_inset, (height - cutout_height + epsilon)]) {
            cube([width, depth, cutout_height]);
        }
        // Extra bit left over from joining channels
        translate([-epsilon, -epsilon, -epsilon]) {
            cube([channel_inset + channel_width + epsilon, channel_inset + channel_width + epsilon, height + 2 * epsilon]);
        }
        translate([holes_offset, holes_offset , -epsilon]) {
            hexagon_lattice(rows=7, cols=7, height=height + 2 * epsilon, radius=holes_radius, row_spacing=holes_spacing, col_spacing=holes_spacing);
        }
    };
};
