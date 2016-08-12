
/*
 * PVC pipes
 */
use <./Lib/ISOThread.scad>;
use <Bearings.scad>;

PIPE_HOLDER_WIDTH = 5;
PVC_PIPE_DIAMETER = 32;
THREADED_ROD_DIAMETER = 4; // M4

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
        rotate([0,90,0])
            cylinder(d = BearingMR105ZZDiameter(), h = PIPE_HOLDER_WIDTH+1, center = true);
        rotate([0,90,0])
            Pipe32(len=PIPE_HOLDER_WIDTH);
        for(i=[0,120,240]) {
            rotate([i,0,0]) 
                translate([-1,0,(PVC_PIPE_DIAMETER/3)])
                    rotate([0,90,0]) translate([0,0,-(PIPE_HOLDER_WIDTH/2)])
                        union() {
                            cylinder(h=10,d=THREADED_ROD_DIAMETER+0.2, $fn =16);
                            hex_nut(4);
                        }
        }
    }
    rotate([0,90,0])
        BearingMR105ZZ();
}

PipeHolder();
