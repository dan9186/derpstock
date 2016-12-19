include <../configuration.scad>

$fn = 24;

module belt_clamp(){
	translate([0.5,0,(1.5*belt_width+1)/2])
	minkowski(){
		cylinder(r=0.5, h=1, center=true);
		hull(){
			translate([extrusion/3,0,0])
			rotate([0,0,180])
			cylinder(r=extrusion/4.5, h=1.25*belt_width+4, center=true, $fn=3);
			translate([extrusion/3+sin(30)*extrusion/3+extrusion/3/2,0,0])
			cube([extrusion/10,cos(30)*extrusion/4.5*2.15,1.25*belt_width+4], center=true);
		}
	}
}

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
            //cylinder(r=gantry_mount_radius+extra_radius, h=carriage_thickness+1);
            for(lr=[-1,1]){
                translate([-10,0,0])
                cylinder(r=gantry_mount_radius+extra_radius, h=carriage_thickness+1);
                translate([0,lr*-10,0])
                cylinder(r=gantry_mount_radius+extra_radius, h=carriage_thickness+1);
            }
        }
    }

    // Belt Clamps
    translate([0,gantry_height/5,0]){
        translate([extrusion/8,0,carriage_thickness])
        belt_clamp();

        for(tb=[-1,1]){
            rotate([0,0,180])
            translate([-2*extrusion/3,tb*(extrusion/6*1.1+belt_width),carriage_thickness])
            belt_clamp();
        }
    }

    // Ball joint mount horns
    for(lr=[-1,1]){
        translate([lr*(gantry_width/2-5),gantry_height/2-gantry_corner_radius-9,carriage_thickness]){
            difference(){
                intersection(){
                    cylinder(r1=10, r2=2.5, h=10);
                    translate([0,0,5])
                    cube([10,20,10], center=true);
                }
                translate([0,0,10])
                screw_socket(2.5,20);
                hull(){
                    cylinder(r=m3_nut_radius, h=m3_nut_thickness, $fn=6);
                    translate([lr*5,0,m3_nut_thickness/2])
                    cube([m3_nut_radius,m3_nut_radius+3,m3_nut_thickness], center=true);
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
