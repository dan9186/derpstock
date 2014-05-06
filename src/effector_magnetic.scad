include <../configuration.scad>;

$fn = 24;

insulator_height = 4.95;
insulator_diameter = 16;
insulator_radius = insulator_diameter/2;

bsp_height = 3.8;
bsp_diameter = 3.5;
bsp_radius = bsp_diameter/2;

effector_diameter = 60;
effector_angle = 30;
effector_height = insulator_height + bsp_height;

effector_radius = effector_diameter/2 + extra_radius;


module effector_magnetic(){
	screw_length = 6;

	intersection(){
	difference(){
			cylinder(r1=effector_radius+effector_height/tan(effector_angle), r2=effector_radius, h=effector_height, $fn=3);

			translate([0,0,-bsp_height])
			cylinder(r=insulator_radius, h=effector_height);

			translate([0,0,1])
			cylinder(r=bsp_radius, h=effector_height);

			for(i=[0:2]){
				rotate([0,0,i*360/3])
				for(tb=[-1,1]){
					translate([-effector_radius*sin(30)-3,tb*(effector_radius-13),effector_height/2])
					rotate([0,-70,0]){
						#cylinder(r=3/2*1.5, h=3*1.25);
						translate([0,0,-screw_length/2])
						#cylinder(r=2.6/2, h=screw_length+0.1, center=true);
					}
				}

				rotate([0,0,i*360/3])
				translate([insulator_radius+5,0,effector_height])
				#screw_socket(3, effector_height+1);
			}
		}

		rotate([0,0,60])
		cylinder(r=effector_radius+2*effector_height/tan(effector_angle), h=effector_height, $fn=3);
	}
}

effector_magnetic();