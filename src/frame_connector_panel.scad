include <../configuration.scad>;

$fn = 24;

module frame_connector_panel(){
	difference(){
		minkowski(){
			cube([150,3*extrusion-5*2, 1.5], center=true);
			cylinder(r=5, h=1, center=true);
		}

		for( tb=[-1,1] ){
			for( lr=[-1,1] ){
				translate([lr*(75-extrusion/2),tb*extrusion,1])
				screw_socket(5, 20);
			}
		}

		// IEC Plug
		translate([-40,0,0]){
			cube([30,21.5,4], center=true);
			for( lr=[-1,1] ){
				translate([lr*20,0,2])
				screw_socket( 3, 20 );
			}
		}

		// Rocker Switch
		cube([12.5+3*extra_space,19+3*extra_space,4], center=true);

		// USB Plug
		translate([40,0,0]){
			cube([12.5+3*extra_space,11.5+3*extra_space,4], center=true);
			for( lr=[-1,1] ){
				translate([lr*26/2,0,2])
				screw_socket( 3, 20 );
			}
		}
	}
}

frame_connector_panel();