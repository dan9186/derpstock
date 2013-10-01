include <configuration.scad>;

$fn = 24;

module glass_tab() {
	// Tab to mount to extrusion to hold up glass
	difference(){
		translate([0,0,thickness/2]) hull(){
			translate([0,sticky_width/2-extrusion/2,0])
			cylinder(r=sticky_width/2, h=thickness, center=true);
			translate([0, extrusion/2+sticky_length/2, 0])
			cube([sticky_width, sticky_length, thickness], center=true);
		}
		# translate([0,0,thickness-m3_socket_height/10]) screw_socket();
	}

	// Extrusion preview
	% translate([0,0,-extrusion/2]) cube([100,extrusion,extrusion], center=true);

	// Sticky pad preview
	% translate([0,sticky_length/2+extrusion/2,thickness+0.7/2])
	cube([sticky_width, sticky_length, 0.7], center=true);
}

glass_tab();

// Glass plate preview
%translate([0,150+extrusion/2,thickness+0.7])
cylinder(r=150, h=3, $fn=60);