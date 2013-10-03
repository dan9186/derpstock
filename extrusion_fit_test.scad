include <configuration.scad>;

$fn = 50;

difference(){
	cylinder( r=extrusion, h=2.5, center=true );
	extrusion_cutout( extrusion, extra_extrusion_clearance*extra_radius );
}
