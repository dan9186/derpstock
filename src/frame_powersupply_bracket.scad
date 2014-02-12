include <../configuration.scad>;
 
$fn = 24;
 
power_supply_width = 122;
power_supply_height = 56;
power_supply_length = 221;
 
//Part Settings
partLength = 60;
width = 15;
thickness = 7;

 
//Aluminum Extrusion Settings
holeSpacing = 40;
 
//Powersupply Settings
power_supply_screw_diameter = 4;
power_supply_screw_separation = 25;
power_supply_hole_shift = 0;
power_supply_extrusion_holes_shift = 45;
 
module frame_powersupply_bracket(){
        difference(){
                union(){
                        translate([0,0,thickness/2]) cube(size=[width,partLength,thickness], center = true);
                        translate([(power_supply_extrusion_holes_shift+(width/2))/2,0,thickness/2])
                        cube([power_supply_extrusion_holes_shift+(width/2),partLength,thickness], center = true);
                }
 
                //Powersupply mounting holes
                #translate([0,power_supply_hole_shift+power_supply_screw_separation/2,thickness-50*extra_space])
                screw_socket( power_supply_screw_diameter, thickness+5 );
 
                #translate([0,power_supply_hole_shift-power_supply_screw_separation/2,thickness-50*extra_space])
                screw_socket( power_supply_screw_diameter, thickness+5 );
       
                //mounting holes for extrusion
                #rotate([180,0,0])
                translate([power_supply_extrusion_holes_shift,-holeSpacing/2-tnut_screw_diameter/2,-extra_space])
                screw_socket(tnut_screw_diameter, tnut_screw_length);
 
                #rotate([180,0,0])
                translate([power_supply_extrusion_holes_shift,holeSpacing/2,-extra_space])
                screw_socket(tnut_screw_diameter, tnut_screw_length);
        }
}
 
frame_powersupply_bracket();
 
%translate([-power_supply_length/3,0,-power_supply_width/2])
cube([power_supply_length,power_supply_height,power_supply_width], center=true);