include <configuration.scad>;

$fn = 24;

module frame_motor() {
	motor_mount_height = 3*extrusion;
	translate([0,0,motor_mount_height/2])
	union(){
		// Pad to improve print bed adhesion for slim ends
		translate( [-37.5, 52.2, -motor_mount_height/2] ) cylinder(r=8, h=0.5);
		translate( [37.5, 52.2, -motor_mount_height/2] ) cylinder(r=8, h=0.5);
	
		difference(){
			// Base vertex shape
			vertex_outline( 3*extrusion );
	
			// Pully cutout
			difference() {
				translate([0, 60.5, 0])
				minkowski() {
					intersection() {
						rotate([0, 0, -90])
						cylinder(r=55, h=3*motor_mount_height+1, center=true, $fn=3);
						translate([0, -32, 0])
						cube([100, 16, 3*motor_mount_height+1], center=true);
					}
					cylinder(r=6, h=1, center=true);
				}
			}
	
			// Motor mounting space cutout
			translate([0, 60.5, 0]) minkowski() {
					intersection() {
					rotate([0, 0, -90])
					cylinder(r=55, h=3*motor_mount_height+1, center=true, $fn=3);
					translate([0, 7, 0])
					cube([100, 30, 3*motor_mount_height+1], center=true);
				}
				cylinder(r=6, h=1, center=true);
			}
	
			// Motor mount cutouts
			translate([0,46.5,0]) rotate([90,0,0]) nema17();
	
			for(lr=[-1, 1]) {
				// Side screw cutouts
				for(z=[-1,1]){
					translate( [0,-30,z*(motor_mount_height/2-extrusion/2)] )
					rotate([0, 0, 30*lr]) {
						for(y=[51, 90]) {
							# translate([lr*11.4, y, 0]) rotate([0, lr*90, 0])
							screw_socket(tnut_screw_diameter, tnut_screw_length);
						}
					}
				}
	
				// Nut tunnels
				rotate([0, 0, 30*lr]) 
				translate([-16*lr, 111, 0]) {
					translate([0, -99.5,0]){
					// Repeat the same thing for top and bottom
						for (z = [-1, 1]){
							hull(){
								translate([0,2.5,z*(motor_mount_height/2-0.5)])
								rotate([0, 0, -lr*30])
								cylinder(r=4, h=extrusion/2+1, center=true, $fn=6);
								translate([0,-2.5,z*(motor_mount_height/2-0.5)])
								rotate([0, 0, -lr*30])
								cylinder(r=4, h=extrusion/2+1, center=true, $fn=6);
							}
						}
	
						hull(){
							translate([0,2.5,0])
							rotate([0, 0, -lr*30])
							cylinder(r=4, h=2*motor_mount_height/3, center=true, $fn=6);
							translate([0,-2.5,0])
							rotate([0, 0, -lr*30])
							cylinder(r=4, h=2*motor_mount_height/3, center=true, $fn=6);
						}
					}
				}
			}
	
			// Logo for the front side of the object
			*translate([20,-extrusion/2,0]) rotate([90,-90,30])
			scale([0.1,0.1,1]) derpstock_logo();
	
			% extrusion_cutout( motor_mount_height+20, extra_extrusion_space );
		}
	}
}

frame_motor();