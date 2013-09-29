include <configuration.scad>;

$fn = 24;

%extrusion_cutout( extrusion + 20, 2  * extra_radius );


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
			cylinder(r1=30, r2=2, h=30-10/2);
			translate([0, 26+0+30+2.5, 0]) rotate([90, 0, 0])
			cylinder(r1=30, r2=2, h=30-10/2);
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

		for (a = [-1, 1]) {
			// Side screw cutouts
			translate( [0,-30,0] )
			rotate([0, 0, 30*a]) { //translate([-16*a, 111, z+7.5-extrusion/2]) {
				for (y = [51, 90]) {
					translate([a*7.5, y, 0]) rotate([0, a*90, 0]) screw_socket();
					% translate([a*7.5, y, 0]) rotate([0, a*90, 0]) screw_socket();
				}
			}

			rotate([0, 0, 30*a]) translate([-16*a, 111, 0]) {
				// Nut tunnels.
				for (y = [0:4]) {
					translate([0, -98-y, (extrusion/4 + 4)])
					rotate([0, 0, -a*30])
					cylinder(r=4, h=extrusion/2+1, center=true, $fn=6);
					translate([0, -98-y, -(extrusion/4 + 4)])
					rotate([0, 0, -a*30])
					cylinder(r=4, h=extrusion/2+1, center=true, $fn=6);
				}
			}
		}

		// Front screw cutout
		translate( [0,-extrusion/2,0] )
		rotate( [90,0,0] ){
			screw_socket();
			% screw_socket();
			translate( [0,0,-2] ) cylinder( r1=7, r2=4, h=4, center=true );
		}

		// Idlear shaft cutout
		translate( [0,extrusion/2 + 45/2 + 5,0] )
		rotate( [90,0,0] ) cylinder( r=2, h=45, center=true );

		// Bearing for idler
		% translate([0,32,0]) rotate([90,0,0]) 608ZZ();
	}
}