module holes (width, height, wall_thickness, thickness, hole_diameter)
{
    // center row is 0
    // dx and dy is distance between holes in two adjacent rows
    d = (hole_diameter + wall_thickness);
    dx = d * cos(60);
    dy = d * sin(60);
    row_hole_half_count = ceil(width / d / 2) + 1;
    row_half_count = ceil(height / d / 2) + 1;
    for (row=[0:row_half_count]) {
        for (col=[0:row_hole_half_count]) {
            y = dy * row;
            x = col * d + (row % 2) * dx;
            translate([x, y, 0]) cylinder(r=hole_diameter/2, h=thickness+1, center=true);
            translate([-x, y, 0]) cylinder(r=hole_diameter/2, h=thickness+1, center=true);
            translate([x, -y, 0]) cylinder(r=hole_diameter/2, h=thickness+1, center=true);
            translate([-x, -y, 0]) cylinder(r=hole_diameter/2, h=thickness+1, center=true);
        }
    }
}

module ledge(inner_width, inner_height, width, thickness) {
    difference () {
        cube([inner_width+width*2, inner_height+width*2, thickness], center=true);
        cube([inner_width, inner_height, thickness+1], center=true);
    }
}

module mesh (width, height, wall_thickness, thickness, hole_diameter, ledge_width, ledge_thickness)
{
    union () {
        difference () {
            cube([width, height, thickness], center=true);
            holes(width, height, wall_thickness, thickness+1, hole_diameter);
        }
        translate([0, 0, -(thickness-ledge_thickness)/2])
            ledge(width, height, ledge_width, ledge_thickness);
    }
}

mesh(width=300, height=200, wall_thickness=5, thickness=7, hole_diameter=30, ledge_width=5, ledge_thickness=3);