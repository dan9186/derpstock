include <../configuration.scad>;

$fn = 24;

module magnetic_cap(){
	translate([0,0,22+magnet_diameter/4])
	rotate([180,0,0])
	difference(){
		union(){
			cylinder(r=magnet_radius+thickness*2/3, h=22);

			translate([0,0,22])
			cylinder(r1=magnet_radius+thickness*2/3, r2=magnet_radius, h=magnet_radius/2);
		}
		translate([0,0,22+magnet_diameter/2-1.75])
		sphere(r=magnet_radius);

		cylinder(r=magnet_radius-1, h=22+1);

		translate([0,0,-1.75])
		cylinder(r=magnet_radius, h=22);
	}
}

magnetic_cap();