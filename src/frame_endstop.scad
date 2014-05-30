include <../configuration.scad>;

module endstop(){
	difference(){
		//Basic Shape
		hull(){
			cylinder(r=extrusion-3, h=10, center=true);
			translate([0,-extrusion/2-10/2,0])
			cube([20+2*thickness,10,10], center=true);
		}

		//Extrusion cutout
		extrusion_cutout(40, extra_extrusion_space);

		//Screw cutout
		translate([(extrusion+6*extra_space)/2+3/2*thickness,0,0])
		rotate([0,90,0])
		screw_socket(5,10);

		translate([(extrusion+extra_extrusion_space-5)/2,0,0])
		cube([5,5,15], center=true);

		//Heatset cutout
		translate([10+thickness/2,-extrusion/2-10/2,0])
		rotate([0,90,0])
		cylinder(r=5.1/2, h=10, center=true);

		//Endstop cutout
		translate([0,-extrusion/2-10/2,0])
		cube([20+8*extra_space,6+6*extra_space,15], center=true);
	}
}

%extrusion_cutout(40, extra_extrusion_space);

%translate([0,-(extrusion)/2-10/2,-5])
microswitch();
endstop();