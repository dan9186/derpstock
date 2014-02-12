include <../configuration.scad>;
 
$fn = 24;
 
module frame_powersupply_bracket(){
	bracket_thickness = 1.25*power_supply_screw_diameter + 2;
	difference(){
		minkowski(){
			translate([0,0,bracket_thickness/2-0.5]){
				union(){
					translate([20+power_supply_mount_hole_inset/3*2,0,0])
					cube([20+power_supply_mount_hole_inset/3,3*extrusion-5/2,bracket_thickness-1], center = true);
					translate([power_supply_mount_hole_inset/3,0,0])
					cube([power_supply_mount_hole_inset,power_supply_screw_separation+2*power_supply_screw_diameter,bracket_thickness-1], center=true);
				}
			}
			cylinder(r=5, h=1);
		}
 
		for( tb=[-1,1] ){
			//Powersupply mounting holes
			translate([0,tb*power_supply_screw_separation/2,2])
			screw_socket( power_supply_screw_diameter, bracket_thickness+5 );
       
			// Extrusion mounting holes
			rotate([180,0,0])
			translate([power_supply_mount_hole_inset+3*power_supply_screw_diameter/2+20/2,tb*extrusion,-3*extra_space])
			#screw_socket(tnut_screw_diameter, tnut_screw_length);
		}
	}
}
 
frame_powersupply_bracket();
 
%translate([-power_supply_length/2+power_supply_mount_hole_inset,0,-power_supply_width/2])
cube([power_supply_length,power_supply_height,power_supply_width], center=true);