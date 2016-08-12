
/*
 * PVC pipes
 */
use <Bearings.scad>;

PIPE_HOLDER_WIDTH = 5;
function PVC_PIPE_DIAMETER() = 32;
function THREADED_ROD_DIAMETER() = 4; // M4

module Pipe( dia=10, w=1, len=100) {
	difference() {
		cylinder(h=len,r=dia/2);
		translate ([0,0,-1]) {
			cylinder(h=len+2,r=dia/2 - w);
		}
	}
}
 
module Pipe32(len = 100) {
    Pipe(dia=32.2, w=1.9, len=len);
}

module PipeHolder(h=40, w=50) {
    difference() {
        cube([PIPE_HOLDER_WIDTH,w,h], center=true);
        PipeHolderMinus(w=PIPE_HOLDER_WIDTH);
    }
    rotate([0,90,0])
        BearingMR105ZZ();
}

module PipeHolderMinus(w=10, bearing = 2) {
    rotate([0,90,0])
	translate([0,0,-bearing/3])
        	cylinder(d = BearingMR105ZZDiameter(), h = w+bearing, center = true);
        rotate([0,90,0])
            Pipe32(len=w);
        for(i=[0,120,240]) {
            rotate([i,0,0]) 
                translate([-1,0,(PVC_PIPE_DIAMETER()/3)])
                    rotate([0,90,0]) translate([0,0,-(w/2)])
                        union() {
                            cylinder(h=w*2,d=THREADED_ROD_DIAMETER()+0.2, $fn =16);
                            translate([0,0,-5])
                            	cylinder(d=8,h=10,$fn=6);
                        }
        }

}

PipeHolder();
