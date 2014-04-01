include <../configuration.scad>

$fn = 24;

module belt_clamp(){
	translate([0.5,0,(1.5*belt_width+1)/2])
	minkowski(){
		cylinder(r=0.5, h=1, center=true);
		hull(){
			translate([extrusion/3,0,0])
			rotate([0,0,180])
			cylinder(r=extrusion/3, h=1.5*belt_width+6.5, center=true, $fn=3);
			translate([extrusion/3+sin(30)*extrusion/3+extrusion/3/2,0,0])
			cube([extrusion/3,cos(30)*extrusion/3*2.15,1.5*belt_width+6.5], center=true);
		}
	}
}

module vslot_carriage(){
	r1 = wheel_separation+20;
	midpoint = (r1-sqrt(pow(25,2)-pow(25/2,2))+r1*sin(30))/2;
	carriage_thickness = thickness*3/2;

	difference(){
		union(){
			// Main Body Triangle
			translate([r1-sqrt(pow(25,2)-pow(25/2,2))-midpoint,0,0])
			intersection(){
				rotate([0,0,180])
				cylinder(r=r1, carriage_thickness, $fn=3 );
				cylinder(r=(r1-sqrt(pow(25,2)-pow(25/2,2)))/sin(30), carriage_thickness, $fn=3 );
			}

			translate([0,(r1*2/3+1)/2,carriage_thickness/2])
			cube([2*midpoint, r1*2/3+1, carriage_thickness], center=true);

			// Belt Clamps
			translate([extrusion/5,0,carriage_thickness])
			belt_clamp();
	
			for(tb=[-1,1]){
				rotate([0,0,180])
				translate([-2*extrusion/3,tb*(extrusion/3*1.1+belt_width),carriage_thickness])
				belt_clamp();
			}

			// Ball joint mount horns
			for(lr=[-1,1]){
				scale([lr,1,1]) intersection() {
					translate([midpoint-15/2,r1*2/3-5,15/2+carriage_thickness])
					cube([15,12,15], center=true);
					translate([midpoint-15/2,r1*2/3-5,carriage_thickness])
					//rotate([0, 90, 0])
					cylinder(r1=14, r2=2.5, h=12);
				}

			translate([lr*(midpoint-15/2),r1*2/3-5,carriage_thickness+12.5])
			#screw_socket(2.8,20);
			}
		}

		// VWheels
		translate([-wheel_separation/2,0,-3-extrusion/2])
		#vwheel();
		for(tb=[-1,1]){
			translate([wheel_separation/2,tb*(wheel_diameter-3),-3-extrusion/2])
			#vwheel();
		}
	}
}

//Extrusion for show
%translate([0,0,-extrusion/2-3])
cube([extrusion, 100, extrusion], center=true);

// Belts
for(lr=[-1,1]){
	translate([lr*22.1/2,0,1.75*thickness/2+1.5*thickness/2+belt_width/2+1])
	%cube([2,150,belt_width], center=true); 
}

vslot_carriage();
