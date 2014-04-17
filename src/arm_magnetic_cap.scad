include <../configuration.scad>;

$fn = 24;

module magnetic_cap(){
	difference(){
		cylinder(r=magnet_radius+thickness*2/3, h=22+magnet_diameter/2);

		translate([0,0,22+magnet_diameter/2])
		sphere(r=magnet_radius+thickness*2/3);

		cylinder(r=magnet_radius-1, h=22);

		translate([0,0,-3])
		cylinder(r=magnet_radius, h=22);
	}
}

magnetic_cap();