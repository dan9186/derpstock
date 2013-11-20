include <../configuration.scad>

$fn = 24;

module vslot_carriage(){
	//Extrusion for show
	%translate([0,0,-extrusion/2-3])
	cube([extrusion, 100, extrusion], center=true);

	carriage_width=wheel_separation+15;
	carriage_height=2.2*extrusion+33;
	difference(){
		union() {
			// Main body.
			translate([0,0, 1.5*thickness/2])
			cube([carriage_width,carriage_height,1.75*thickness], center=true);

			// Ball joint mount horns
			for(lr=[-1,1]){
				scale([lr,1,1]) intersection() {
					translate([0,carriage_height/2-18/2,1.5*belt_width/2+1.75*thickness/2])
					cube([carriage_width+12,18,1.5*belt_width+1.75*thickness], center=true);
					translate([carriage_width/2-12/2,carriage_height/2-18/2,(1.75*thickness+2*belt_width)/2]) rotate([0, 90, 0])
					cylinder(r1=14, r2=2.5, h=12);
				}
			}

			// Belts
			for(lr=[-1,1]){
				translate([lr*22.1/2,0,1.75*thickness/2+1.5*thickness/2+belt_width/2+1])
				%cube([2,150,belt_width], center=true); 
			}

			// Belt Clamps
			for(y=[-1,1]){
				translate([extrusion*1/3-4,y*(carriage_height/8+2),1.75*thickness/2+1.5*thickness/2+1.5*belt_width/2])
				cube([extrusion*2/3,carriage_height/8,1.5*belt_width], center=true);
			}
			translate([extrusion*2/3-2,0,1.75*thickness/2+1.5*thickness/2+1.5*belt_width/2])
			minkowski(){
				cylinder(r=0.5, h=1, center=true);
				hull(){
					translate([-(carriage_height/8-1)/2,0,0])
					rotate([0,0,180])
					cylinder(r=(carriage_height/8-1)/2, h=1.5*belt_width, center=true, $fn=3);
					translate([(extrusion*2/3-carriage_height/16)/2-1,0,0])
					cube([extrusion*2/3-carriage_height/16,carriage_height/8-2.15,1.5*belt_width], center=true);
				}
			}
		}

		for(lr=[-1,1]){
			// Screw holes for arms
			translate([lr*(carriage_width/2-12/2+15),carriage_height/2-18/2,(1.75*thickness+2*belt_width)/2])
			rotate([0,lr*90,0])
			#screw_socket( 3, 20 );

			translate([lr*(carriage_width/2-9),carriage_height/2-18/2,(1.75*thickness+2*belt_width)/2])
			rotate([0,lr*90,0])
			cylinder( r=m3_nut_radius, h=12, $fn=6, center=true );
		}

		// Shift wheel screws out of the arm mount
		translate([0,-7,0]){
			// Wheel screws
			translate([-wheel_separation/2,0,1.25*5])
			screw_socket(5,20);

			for(tb=[-1,1]){
				translate([wheel_separation/2,tb*20,1.25*5])
				screw_socket(5,20);
			}
		}
	}
}

vslot_carriage();	