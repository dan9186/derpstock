/*
	Authors: Daniel Hess (dan9186)
	Original Base: Kossel https://github.com/jcrocholl/kossel
*/

// Increase to add extra space to holes.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// Vslot 20x20 extrusions
extrusion = 20;

module 608zz(){
	difference(){
		cylinder( r=22.1/2, h=7.05 );
		translate( [0,0,-0.25] ) cylinder( r=8/2, h=7.5 );
		translate([0,0,6.05])
		difference(){
			cylinder( r=8/2+5.5, h=1.5 );
			translate( [0,0,-.25] ) cylinder( r=4+1.6, h=2 );
		}
		translate([0,0,-.5])
		difference(){
			cylinder( r=8/2+5.5, h=1.5 );
			translate( [0,0,-.25] ) cylinder( r=4+1.6, h=2 );
		}	
	}
}

#608zz();

		