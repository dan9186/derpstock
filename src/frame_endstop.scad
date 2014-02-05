include <../configuration.scad>;

heat_screw_insert = 3;

module endstop(){
	difference(){
		// Outside cube shape
		union(){
			cube([extrusion, 1.25*tnut_screw_diameter, extrusion], center=true);
			translate([0, 0, -extrusion/4])
			cube([extrusion+2, 1.25*tnut_screw_diameter, extrusion/2], center=true);
			translate([0, 2, 0])
			cube([2.5, 1.25*tnut_screw_diameter, extrusion], center=true);
		}

		// Screw socket cutout
		translate([0, 0, 3]) rotate([90, 0, 0]){
			cylinder(r=tnut_screw_diameter/2+extra_radius, h=20, center=true, $fn=12);
			translate([0, 0, tnut_screw_diameter - 1.25*tnut_screw_diameter]){
				cylinder(r=tnut_screw_diameter/2+10*extra_radius, h=10, $fn=24);
				translate([0, 5, 5])
				cube([tnut_screw_diameter+20*extra_radius, 10, 10], center=true);
			}
			translate([0, 0, -1.25*tnut_screw_diameter+3+extra_radius]) scale([1, 1, -1])
			cylinder(r1=tnut_screw_diameter/2+extra_radius, r2=1.4*tnut_screw_diameter+extra_radius, h=4, $fn=24);
		}

		//microswitch
		translate([0, -1.25*tnut_screw_diameter, -2]) rotate([0, 180, 0]){
			% microswitch();
			for (x = [-9.5/2, 9.5/2]){
				translate([x, 0, 0]) rotate([90, 0, 0])
				cylinder(r=2.5/2, h=40, center=true, $fn=12);
			}
		}
	}
}

difference(){
	translate([0,-(extrusion+extra_extrusion_space)/2-thickness-3,5])
	cube([extrusion+2*thickness,6+2*thickness,10], center=true);

	translate([-10,-(extrusion+extra_extrusion_space)/2-6-thickness-extra_space,-1])
	cube([20,6+2*extra_space,12]);
}

%extrusion_cutout(40, extra_extrusion_space);

%translate([0,-(extrusion+extra_extrusion_space)/2-3-thickness,0])
microswitch();