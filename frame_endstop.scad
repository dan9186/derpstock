include <configuration.scad>;

module endstop(){
	difference(){
		union(){
			cube([extrusion, m3_socket_height*2, extrusion], center=true);
			translate([0, 0, -extrusion/4])
			cube([extrusion+2, m3_socket_height*2, extrusion/2], center=true);
			translate([0, 2, 0])
			cube([2.5, m3_socket_height*2, extrusion], center=true);
		}
		translate([0, 0, 3]) rotate([90, 0, 0]){
			cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
			translate([0, 0, 3.6-m3_socket_height]){
				cylinder(r=3, h=10, $fn=24);
				translate([0, 5, 5])
				cube([6, 10, 10], center=true);
			}
			translate([0, 0, -m3_socket_height]) scale([1, 1, -1])
			cylinder(r1=m3_wide_radius, r2=7, h=4, $fn=24);
		}
		translate([0, -3-m3_socket_height, -2]) rotate([0, 180, 0]){
			% microswitch();
			for (x = [-9.5/2, 9.5/2]){
				translate([x, 0, 0]) rotate([90, 0, 0])
				cylinder(r=2.5/2, h=40, center=true, $fn=12);
			}
		}
	}
}

translate([0, 0, extrusion/2]) endstop();