include <../configuration.scad>;

$fn = 24;

module ramps_mount(){
	arduino_screw = 3/2+3*extra_radius;
	support_radius = arduino_screw+2;
	support_height = 2/5*extrusion;
	difference() {
		union() {
			// Arduino Supports
			cylinder(r=support_radius,h=support_height);
			translate([1,48,0]) cylinder(r=support_radius,h=support_height);
			translate([81.5,0,0]) cylinder(r=support_radius,h=support_height);
			translate([75,48,0]) cylinder(r=support_radius,h=support_height);

			hull(){
				cylinder(r=support_radius+3, h=2);
				translate([75,48,0]) cylinder(r=support_radius+3,h=2);
				translate([81.5,0,0]) cylinder(r=support_radius+3,h=2);
				translate([1,48,0]) cylinder(r=support_radius+3,h=2);
			}

			// Bar supports
			translate([-3,-19,0]) cube([support_radius*2,18,support_height-1]);
			translate([77,-19,0]) cube([support_radius*2,18,support_height-1]);
			translate([support_radius,-18,0])rotate([0,0,3.5])
			cube([support_radius,63,support_height-1]);
			translate([80-support_radius,-18,0])rotate([0,0,3.5])
			cube([support_radius,63,support_height-1]);

			// Extrusion Plate
			minkowski(){
				translate([-extrusion,-19,3-extra_space]) cube([2*extrusion+81.5,thickness,extrusion+2*extra_space-6]);
				rotate([90,0,0])cylinder(r=3, h=1);
			}
		}

		// Arduino Holes
		translate([0,0,1]) cylinder(r=arduino_screw,h=support_height);
		translate([1,48,1]) cylinder(r=arduino_screw,h=support_height);
		translate([81.5,0,1]) cylinder(r=arduino_screw,h=support_height);
		translate([75,48,1]) cylinder(r=arduino_screw,h=support_height);

		// Extrusion Mounting Holes
		rotate([-90,0,0]) translate([-extrusion/2,-extrusion/2,-19+thickness-thickness/10])
		screw_socket( 5, 10 );
		rotate([-90,0,0]) translate([81.5+extrusion/2,-extrusion/2,-19+thickness-thickness/10])
		screw_socket( 5, 10 );
	}
}

ramps_mount();