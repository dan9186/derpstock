include <../configuration.scad>

$fn = 24;

arm = 21.5;
arm2 = 29;

/*difference(){
	union(){
		translate([-arm/2-wheel_screw_hole_size/2-0.5,0,0])
		minkowski(){
			cylinder( $fn=200, h1, r=3, center=true );
			cube([arm,wheel_screw_hole_size,1], center=true);
		}

		rotate( 45, [0,0,1])
		translate([arm2/2+wheel_screw_hole_size/2+0.5,0,0])
		minkowski(){
			cylinder( $fn=200, h1, r=3, center=true );
			cube([arm2,wheel_screw_hole_size,1], center=true);
		}

		mirror([0,1,0]){
			rotate( 45, [0,0,1])
			translate([arm2/2+wheel_screw_hole_size/2+0.5,0,0])
			minkowski(){
				cylinder( $fn=200, h1, r=3, center=true );
				cube([arm2,wheel_screw_hole_size,1], center=true);
			}
		}
	}

   translate([20.2,20.2,0])
   cylinder( $fn=200, h=3, r=wheel_screw_hole_size/2, center=true );
   translate([20.2,-20.2,0])
   cylinder( $fn=200, h=3, r=wheel_screw_hole_size/2, center=true );
   translate([-20.2,0,0])
   cylinder( $fn=200, h=3, r=wheel_screw_hole_size/2, center=true );
}*/

module vslot_carriage(){
	//Extrusion for show
	%translate([0,0,-extrusion/2-3])
	cube([extrusion, 100, extrusion], center=true);

	joint_radius=arm_screw_diameter/2+3*extra_radius;

	translate([0,(4*joint_radius)/2,1.5*joint_radius]){
		difference(){
			cube([(extrusion+7.5+extra_space)*2,4*joint_radius, 2*1.5*joint_radius], center=true);
			for(lr=[1,-1]){
				translate([-lr*(extrusion+7.5+extra_space),0,0])
				difference(){
					cube([19,4*joint_radius+1,2*1.5*joint_radius+1], center=true);
					rotate([0,lr*90,0])
					cylinder(h=10,r1=joint_radius, r2=3*joint_radius);
				}
			}
			rotate([0,90,0])
			cylinder( h=(extrusion+5+extra_space)*2+1, r=arm_screw_diameter/2, center=true );
		}
	}
	cube([2*extrusion,45,thickness], center=true);
	
}

vslot_carriage();