include <configuration.scad>;

$fn = 50;

difference(){
	cylinder( r=extrusion, h=5, center=true );
	extrusion_cutout( extrusion, 2*extra_radius );
}