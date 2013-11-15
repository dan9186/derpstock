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

			/*
			// Belt clamps.
			difference() {
				union() {
					translate([6.5, -2.5, horn_thickness/2+1])
					cube([14, 7, horn_thickness-2], center=true);
					translate([10.75, 2.5, horn_thickness/2+1])
					cube([5.5, 16, horn_thickness-2], center=true);
				}
				// Avoid touching diagonal push rods (carbon tube).
				translate([20, -10, 12.5]) rotate([35, 35, 30])
				cube([40, 40, 20], center=true);
			}
			for (y = [-12, 7]) {
				translate([1.25, y, horn_thickness/2+1])
				cube([7, 8, horn_thickness-2], center=true);
			}*/
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