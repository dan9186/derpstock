/*
	Authors: Daniel Hess (dan9186)
			 Claudio (orias)
	Original Base: Kossel https://github.com/jcrocholl/kossel
*/

//******* Includes *******//
// More Fontz! by polymaker http://www.thingiverse.com/thing:13677
include <Orbitron_Medium.scad>;


//******* Varaibles *******//

// Increase to add extra space to holes.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi use 15, for Vslot 20
extrusion = 20;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;


//******* Universal Objects *******//

// Basic 608ZZ bearing
module 608ZZ(){
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

// NEMA 17 stepper motor.
module nema17() {
	difference() {
		union() {
			translate([0, 0, -motor_length/2]) intersection() {
				cube([42.2, 42.2, motor_length], center=true);
				cylinder(r=25.1, h=motor_length+1, center=true, $fn=60);
			}
			cylinder(r=11, h=4, center=true, $fn=32);
			cylinder(r=2.5, h=48, center=true, $fn=24);
		}
		for (a = [0:90:359]) {
			rotate([0, 0, a]) translate([15.5, 15.5, 0])
			cylinder(r=m3_radius, h=10, center=true, $fn=12);
		}
	}
}

module derpstock_logo(){
	// steps - the amount of detail, the higher the more detailed.
	// center - whether the output is centered or not
	// extra - extra distance between characters
	// height - height of extrusion, 0 for 2d
	Orbitron_Medium("DERPSTOCK", steps=2, center=true, extra=10, height=5);
}