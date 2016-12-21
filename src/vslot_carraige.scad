include <../configuration.scad>

$fn = 24;

module vslot_carriage(){
	carriage_thickness = thickness;

    difference(){
        hull(){
            for(tb=[-1,1]){
                for(lr=[-1,1]){
                    translate([lr*(gantry_width/2-gantry_corner_radius),tb*(gantry_height/2-gantry_corner_radius),0])
                    cylinder(r=gantry_corner_radius, h=carriage_thickness);
                }
            }
        }

        translate([0,0,-0.5]){
            cylinder(r=gantry_mount_radius+extra_radius, h=carriage_thickness+1);
            for(lr=[-1,1]){
                translate([lr*10,0,0])
                cylinder(r=gantry_mount_radius+extra_radius, h=carriage_thickness+1);
                translate([0,lr*10,0])
                cylinder(r=gantry_mount_radius+extra_radius, h=carriage_thickness+1);
            }
        }
    }

    // Belt Posts
    for(tb=[-1,1]){
        hull(){
            translate([22.1/2,0,carriage_thickness]){
                translate([0,tb*10,0])
                cylinder(r=4, h=1.5*belt_width);
                translate([0,tb*16,0])
                cylinder(r=0.5, h=1.5*belt_width);
            }
        }
    }

    // Ball joint mount horns
    for(lr=[-1,1]){
        horn_base=10;
        translate([lr*(gantry_width/2),gantry_height/2-gantry_corner_radius-9,horn_base/2]){
            rotate([0,lr*90,0]){
            difference(){
                union(){
                    intersection(){
                        cylinder(r1=horn_base, r2=2.5, h=10);
                        translate([0,0,5])
                        cube([horn_base,20,10], center=true);
                    }
                    translate([0,0,-2.5])
                    intersection(){
                        cube([horn_base,20,5], center=true);
                        cylinder(r=horn_base, h=5, center=true);
                    }
                }
                translate([0,0,10])
                screw_socket(2.5,20);
                rotate([0,0,180])
                hull(){
                    cylinder(r=m3_nut_radius, h=m3_nut_thickness, $fn=6);
                    translate([lr*5,0,m3_nut_thickness/2])
                    cube([m3_nut_radius,m3_nut_radius+3,m3_nut_thickness], center=true);
                }
            }
            }
        }
    }
}

//Mini v gantry for show
%translate([0,0,-gantry_thickness])
mini_gantry();

// Belts
for(lr=[-1,1]){
	translate([lr*22.1/2,0,1.75*thickness/2+1.5*thickness/2+belt_width/2+1])
	%cube([2,150,belt_width], center=true);
}

vslot_carriage();
