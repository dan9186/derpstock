include <../configuration.scad>;

heat_screw_insert = 3;

module endstop(){
	difference(){
		union(){
			translate([0,-(extrusion+extra_extrusion_space)/2-thickness-3,5])
			cube([extrusion+2*thickness,6+2*thickness,10], center=true);

			translate([extrusion/2,-(6+2*thickness)/2,5])
			cube([thickness+extrusion/2,extrusion+6*extra_space+6+2*thickness,10], center=true);
		}

		translate([-10,-(extrusion+extra_extrusion_space)/2-6-thickness-extra_space,-1])
		cube([20,6+2*extra_space,12]);

		translate([(extrusion+6*extra_space)/2+3/2*thickness,0,5])
		rotate([0,90,0])
		screw_socket(5,10);

		translate([(extrusion+thickness+1)/2,-(extrusion+6*extra_space)/2-(6+2*thickness)/2,5])
		rotate([0,90,0])
		cylinder(r=2,h=10,center=true,$fn=20);

		extrusion_cutout(40, extra_extrusion_space);
	}
}

%extrusion_cutout(40, extra_extrusion_space);

%translate([0,-(extrusion+extra_extrusion_space)/2-3-thickness,0])
microswitch();
endstop();