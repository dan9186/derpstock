include <../configuration.scad>;

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
			translate([0,extrusion+16.5,0])
			hull(){
				for( x=[-1,1]){
					translate([x*extrusion*0.90,0,0])
					cylinder( r=6, h=motor_mount_height+1, center=true );
					translate([x*extrusion*0.44,-16,0])
					cylinder( r=6, h=motor_mount_height+1, center=true );
				}
			}
	
			// Motor mounting space cutout
			translate([0,extrusion+2*16.5+7.5, 0]) minkowski() {
					intersection() {
					rotate([0, 0, -90])
					cylinder(r=55, h=3*motor_mount_height+1, center=true, $fn=3);
					translate([0, 7, 0])
					cube([100, 30, 3*motor_mount_height+1], center=true);
				}
				cylinder(r=6, h=1, center=true);
			}
	
			// Motor mount cutouts
			translate([0,extrusion+26.5,0]) rotate([90,0,0]){
				nema17_mounts();
				% nema17();
			}

			// Motor screw access tunnels
			for ( z = [-1, 1] ){
				for ( lr = [-1, 1] ){
					translate([lr*16,20.25+30-extrusion/2,z*15.5]) rotate([90,0,lr*30])
					cylinder(r=3*1.5/2+extra_radius*6, h=30, $fn=12);
				}
			}
	
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

				// Electronics wiring access
				translate( [0,-30,0] )
				rotate([0, 0, 30*lr]) {
					translate([lr*10, 90, 0]) rotate([0, lr*90, lr*45])
					cube([15,5,20], center=true);
				}
	
				// Nut tunnels
				rotate([0, 0, 30*lr]) 
				translate([-17.5*lr, 111, 0]) {
					translate([0, -99.5,0]){
					// Repeat the same thing for top and bottom
						for (z = [-1, 1]){
							hull(){
								translate([0,5.5,z*(motor_mount_height/2-0.5)])
								rotate([0, 0, -lr*30])
								cylinder(r=tnut_width/sqrt(3)+3*extra_radius, h=extrusion/2+1, center=true, $fn=6);
								translate([0,-5.5,z*(motor_mount_height/2-0.5)])
								rotate([0, 0, -lr*30])
								cylinder(r=tnut_width/sqrt(3)+3*extra_radius, h=extrusion/2+1, center=true, $fn=6);
							}
						}

						// Wire access
						hull(){
							translate([0,2.5,0])
							rotate([0, 0, -lr*30])
							cylinder(r=tnut_width/sqrt(3)+extra_radius, h=0.75*extrusion, center=true, $fn=6);
							translate([0,-2.5,0])
							rotate([0, 0, -lr*30])
							cylinder(r=tnut_width/sqrt(3)+extra_radius, h=0.75*extrusion, center=true, $fn=6);
						}
					}
				}
			}

			// Wire access to extrusion
			translate([0,0,0])
			cube([extrusion+15,8,0.75*extrusion], center=true);
	
			// Logo for the front side of the object
			translate([20,-extrusion/2,0]) rotate([90,-90,30])
			scale([0.1,0.1,1]) derpstock_logo();
	
			% extrusion_cutout( motor_mount_height+20, extra_extrusion_space );
		}
	}
}

frame_motor();