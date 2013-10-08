$fn = 200;
adapter_radius = 30;
adapter_height = 6.86;
extruder_radius = 5.75;
spacer_wall_thickness = 2;
spacer_height = 4.2;
cable_radius = 3.75;
mounting_holes = 12;

difference(){
	union(){
		cylinder( $fn=1000, r=adapter_radius, h=adapter_height );
		translate( [0,0,adapter_height] )
		cylinder( r=(extruder_radius + spacer_wall_thickness), h=spacer_height );
	}

	translate( [0,0,-1] )
	cylinder( r=extruder_radius, h=(adapter_height + spacer_height + 2) );

	for ( i = [0:2] ){
		rotate( i * 360 / 3, [0,0,1] )
		translate( [14.45,0,-1] )
		cylinder( r=extruder_radius, h=(adapter_height + 2) );
	}

	for ( i = [0:(mounting_holes - 1)] ){
		rotate( i * 360 / mounting_holes, [0,0,1] )
		translate( [0,25,-1] )
		cylinder( r=2.25, h=(adapter_height + 2) );
	}

	for ( i = [0:2] ){
		rotate( i * 360 / 3, [0,0,1] )
		translate( [-15,0,-1] ){
			hull(){
				translate( [-2.5,0,0] )
				cylinder( r=cable_radius, h=(adapter_height + 2) );
				translate( [2.5,0,0] )
				cylinder( r=cable_radius, h=(adapter_height + 2) );
			}
		}
	}
}