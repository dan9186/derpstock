include <configuration.scad>;

$fn = 24;

translate( [0,0,extrusion/2] )
union(){
	// Pad to improve print bed adhesion for slim ends
	translate( [-37.5, 52.2, -extrusion/2] ) cylinder(r=8, h=0.5);
	translate( [37.5, 52.2, -extrusion/2] ) cylinder(r=8, h=0.5);

	difference(){
		// Start with a base outline that is only one extrusion width high
		vertex_outline( extrusion );

		// Idler cutout
		difference() {
			translate([0, 60.5, 0])
			minkowski() {
				intersection() {
					rotate([0, 0, -90])
					cylinder(r=55, h=extrusion, center=true, $fn=3);
					translate([0, -32, 0])
					cube([100, 16, 2*extrusion], center=true);
				}
				cylinder(r=6, h=1, center=true);
			}

			// Idler support cones.
			translate([0, 26+0-30+2.5, 0]) rotate([-90, 0, 0])
			cylinder(r1=30, r2=m3_wide_radius + 5*extra_radius, h=30-10/2);
			translate([0, 26+0+30+2.5, 0]) rotate([90, 0, 0])
			cylinder(r1=30, r2=m3_wide_radius + 5*extra_radius, h=30-10/2);
		}

		// Back space cutout
		translate([0, 60.5, 0]) minkowski() {
			intersection() {
				rotate([0, 0, -90])
				cylinder(r=55, h=extrusion, center=true, $fn=3);
				translate([0, 7, 0])
				cube([100, 30, 2*extrusion], center=true);
			}
			cylinder(r=6, h=1, center=true);
		}

		// Repeat the same thing for the left and right sides
		for (lr = [-1, 1]) {
			// Side screw cutouts
			translate( [0,-30,0] )
			rotate([0, 0, 30*lr]) {
				for (y = [51, 90]) {
					# translate([lr*11.4, y, 0]) rotate([0, lr*90, 0]) screw_socket();
				}
			}

			// Nut tunnels
			rotate([0, 0, 30*lr]) 
			translate([-16*lr, 111, 0]) {
				translate([0, -99.5,0])
				// Repeat the same thing for top and bottom
				for (z = [-1, 1]){
					hull(){
						translate([0,2.5,z*(extrusion/4+0.5+4)]) rotate([0, 0, -lr*30])
						cylinder(r=4, h=extrusion/2+1, center=true, $fn=6);
						translate([0,-2.5,z*(extrusion/4+0.5+4)]) rotate([0, 0, -lr*30])
						cylinder(r=4, h=extrusion/2+1, center=true, $fn=6);
					}
				}
			}
		}

		// Front screw cutout
		rotate( [90,0,0] ){
			# translate([0,0,extrusion/2+extra_radius+m3_socket_height])
			screw_socket();
			translate([0,0,extrusion/2+extra_radius-2])
			cylinder(r1=7, r2=4, h=4, center=true);
		}

		// Idlear shaft cutout
		translate( [0,extrusion/2 + 45/2 + 5,0] )
		rotate( [90,0,0] ) cylinder( r=2, h=45, center=true );

		// Bearing for idler
		% translate([0,32,0]) rotate([90,0,0]) 608ZZ();

		// Extrusion
		% extrusion_cutout( extrusion + 20, 2  * extra_radius );
	}
}