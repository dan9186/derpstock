include <../configuration.scad>;

$fn = 24;

module frame_support(){
	offset_from_corner = 3*extrusion;
	screw_plate_width = extrusion+5*extra_space;
	support_thickness = thickness*1.5+extra_space;

	difference(){
		// Basic shape
		union(){
			// Horizontal screw plate
			hull(){
				translate([-screw_plate_width/2,-screw_plate_width*3-offset_from_corner,0])
				cube([screw_plate_width, screw_plate_width, support_thickness]);

				translate([0,-screw_plate_width/2-offset_from_corner,0])
				cylinder(r=screw_plate_width/2, h=support_thickness);
			}

			// Vertical screw plate
			hull(){
				translate([screw_plate_width*2+offset_from_corner,-screw_plate_width/2,-5*support_thickness])
				cube([screw_plate_width, screw_plate_width, support_thickness*6]);

				translate([screw_plate_width/2+offset_from_corner,0,-5*support_thickness])
				cylinder(r=screw_plate_width/2, h=support_thickness*6);
			}

			// Crossbar
			hull(){
				translate([-screw_plate_width/2,-screw_plate_width*2-offset_from_corner,0])
				cube([screw_plate_width, screw_plate_width, support_thickness]);

				translate([0,-screw_plate_width/2-offset_from_corner,0])
				cylinder(r=screw_plate_width/2, h=support_thickness);

				translate([screw_plate_width+offset_from_corner,-screw_plate_width/2,0])
				cube([screw_plate_width, screw_plate_width, support_thickness]);

				translate([screw_plate_width/2+offset_from_corner,0,-2.5*support_thickness])
				cylinder(r=screw_plate_width/2, h=3.5*support_thickness);
			}
		}

		// Cutout to ensure flat against horizontal beam
		translate([-screw_plate_width/2,-screw_plate_width*3-offset_from_corner,-support_thickness])
		cube([screw_plate_width, 4*screw_plate_width, support_thickness]);

		// Cutout for vertical support flat side
		translate([offset_from_corner-1,0,-5*support_thickness-20])
		rotate([30,0,0])
		cube([screw_plate_width*4, screw_plate_width*2, support_thickness*5]);

		// Skeletal Cutouts
		translate([offset_from_corner-3,-screw_plate_width-5,-support_thickness*4])
		rotate([0,0,-45])
		hull(){
			translate([-screw_plate_width/2.5,-screw_plate_width/3,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
			translate([-screw_plate_width/2.5,screw_plate_width/3,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
			translate([screw_plate_width/2.5,-screw_plate_width/1.5,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
			translate([screw_plate_width/2.5,screw_plate_width/1.5,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
		}

		translate([screw_plate_width+5,-offset_from_corner+3,-support_thickness*4])
		rotate([0,0,135])
		hull(){
			translate([-screw_plate_width/2.5,-screw_plate_width/3,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
			translate([-screw_plate_width/2.5,screw_plate_width/3,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
			translate([screw_plate_width/2.5,-screw_plate_width/1.5,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
			translate([screw_plate_width/2.5,screw_plate_width/1.5,0])
			cylinder(r=screw_plate_width/4, h=support_thickness*6);
		}

		// Screw Cutouts
		translate([0,-5.5*screw_plate_width,support_thickness-extra_space*4])
		screw_socket(5,20);

		translate([0,-4*screw_plate_width,support_thickness-extra_space*4])
		screw_socket(5,20);

		translate([5.5*screw_plate_width,0,-3*support_thickness])
		rotate([30,0,0])
		cylinder(r=5/2+5*extra_radius, h=50, center=true);

		translate([4*screw_plate_width,0,-3*support_thickness])
		rotate([30,0,0])
		cylinder(r=5/2+5*extra_radius, h=60, center=true);

		translate([5.5*screw_plate_width,-extrusion/2-5/2,support_thickness])
		rotate([30,0,0])
		cylinder(r=5*1.5/2+10*extra_radius, h=42, center=true);

		translate([4*screw_plate_width,-extrusion/2-5/2,support_thickness])
		rotate([30,0,0])
		cylinder(r=5*1.5/2+10*extra_radius, h=42, center=true);
	}
}

rotate([180,0,0])
frame_support();
