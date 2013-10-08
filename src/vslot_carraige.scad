wheel_screw_hole_size = 5;
arm = 21.5;
arm2 = 29;

difference(){
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
}