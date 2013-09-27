include <configuration.scad>;

$fn = 24;

%extrusion_cutout( extrusion + 20, 2  * extra_radius );


/*union(){
	// Pad to improve print bed adhesion for slim ends
	translate([-37.5, 52.2, -extrusion/2]) cylinder(r=8, h=0.5);
	translate([37.5, 52.2, -extrusion/2]) cylinder(r=8, h=0.5);

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
	}

	// Bearing for idler
	% translate([0,32,0]) rotate([90,0,0]) 608ZZ();
}*/

//for (z = [0:30:extrusion]) {
	//translate([0, -7.5-extra_radius, z+7.5-extrusion/2]) rotate([90, 0, 0])
	//screw_socket_cone();
//	for (a = [-1, 1]) {
//		rotate([0, 0, 30*a]) { //translate([-16*a, 111, z+7.5-extrusion/2]) {
			// % rotate([90, 0, 0]) extrusion_cutout(200, 0);
			// Screw sockets.
			for (y = [44, 88]) {
				translate([0, y, 0]) rotate([0, 90, 0])
				screw_socket();
			}
			// Nut tunnels.
			/*for (z = [-1, 1]) {
				scale([1, 1, z]) translate([0, -100, 3]) minkowski() {
					rotate([0, 0, -a*30]) cylinder(r=4, h=16, $fn=6);
					cube([0.1, 5, 0.1], center=true);
				}
			}*/
//		}
//	}
//}
