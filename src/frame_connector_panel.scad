include <../configuration.scad>;

$fn = 24;

module frame_connector_panel(){
	plate_thickness = 6.5;
	difference(){
		// Base plate
		minkowski(){
			cube([150,3*extrusion-5*2, plate_thickness - 1], center=true);
			cylinder(r=5, h=1, center=true);
		}

		// Extrusion Tnut holes
		for( tb=[-1,1] ){
			for( lr=[-1,1] ){
				translate([lr*(75-extrusion/2),tb*extrusion,plate_thickness/2-5*extra_space])
				screw_socket(5, 20);
			}
		}

		// IEC Plug
		translate([-40,0,0]){
			cube([30,21.5,plate_thickness+2], center=true);
			for( lr=[-1,1] ){
				translate([lr*20,0,2])
				screw_socket( 3-2*extra_radius, 20 );
			}
		}

		// Rocker Switch
		cube([12.5+3*extra_space,19+3*extra_space,plate_thickness+2], center=true);

		// USB Plug
		translate([40,0,0]){
			cube([12.5+3*extra_space,11.5+3*extra_space,plate_thickness+2], center=true);
			for( lr=[-1,1] ){
				translate([lr*26/2,0,2])
				screw_socket( 3, 20 );
			}

			intersection(){
				cube([18*2,20,10],center=true);
				translate([0,0,-plate_thickness/2+2.5])
				cylinder(r=18, h=10);
			}
		}

		translate([0,extrusion-4,plate_thickness/2])
		scale([0.15,0.15,1])
		derpstock_logo();


	}
}

frame_connector_panel();