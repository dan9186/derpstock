include <../configuration.scad>;

// Determine what fits and then use the changes to apply
// across the entire set of models via the configuration file.

$fn = 30;

extrusion_extra = 5*extra_space;

union(){
	difference(){
		minkowski(){
			cube([3.5*extrusion-12,2.5*extrusion-12,thickness/2], center=true);
			cylinder(r=6, h=thickness/2, center=true);
		}

		translate([-extrusion,0,0])
		extrusion_cutout( extrusion, extrusion_extra );

		translate([-6,extrusion/1.25,thickness/2-5/2*0.2+0.2]) scale([0.1,0.1,0.2])
		derpstock_logo();

		for( y=[-1,1] ){
			translate([0,y*extrusion/2,thickness/2-1])
			screw_socket(tnut_screw_diameter,tnut_screw_length);
		}

		translate([extrusion*2/3,0,0])
		for( y=[-1,1] ){
			translate([0,y*extrusion/2,thickness/2])
			cylinder(r=m3_nut_radius, h=thickness, center=true, $fn=6);
		}
	}

	translate([1.3*extrusion,0,(1.5*extrusion-12)/2-1.25])
	rotate([0,-90,0])
	difference(){
		union(){
			translate([-extrusion/4,0,0])
			cube([extrusion/2-1,1.5*extrusion+12,2*thickness], center=true);
			minkowski(){
				cube([extrusion-13,1.5*extrusion-12,thickness], center=true);
				cylinder(r=6, h=thickness, center=true);
			}
		}

		for(y=[-1,1]){
			translate([0,y*(1.5*extrusion/2+5.935),0])
			cylinder(r=6, h=2*thickness+1, center=true);

			translate([0,y*extrusion/3,thickness-1])
			screw_socket(tnut_screw_diameter,tnut_screw_length);

			translate([0,y*extrusion/3,-thickness])
			cylinder(r=m3_nut_radius, h=thickness, center=true, $fn=6);
		}
	}
}
