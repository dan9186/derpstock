include <configuration.scad>;

$fn = 50;

difference(){
	cylinder( r=extrusion, h=2.5, center=true );
	extrusion_cutout( extrusion, 4.5*extra_radius );
}
