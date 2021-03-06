
/*
 * Connecting two arms
 */
use <Gears.scad>;
use <Bearings.scad>;
use <Pipe.scad>;

MiddleCaseWidth = 90;
MiddleCaseLength = 90;
MiddleCaseHeight = 50;
MiddleCaseWallTickness = 3;

// Size of arm pipe plus spare 5%
PipeCut = 33;
// Screws diameter
MountScrews = 3;
// Nut diameter
MountNutDia = 6.4;

module MiddleCase() {
    //union() {
        %color("Yellow") MiddleCaseTop();
        color("Blue") MiddleCaseBottom();
    //}
}

module MiddleCaseTop() {
	difference() {
        MiddleCaseBody();
        BodyCut();
    }
}

module MiddleCaseBottom() {
	intersection() {
		MiddleCaseBody();
        BodyCut();
	}
}

module BodyCut() {
    union() {
        translate([-MiddleCaseWidth,-MiddleCaseLength*1.5,-(MiddleCaseHeight/2)-10])
            cube([MiddleCaseWidth*2,MiddleCaseLength*2,(MiddleCaseHeight/2)+10]);
        translate([-5,-20,-8])
            cube([MiddleCaseWidth*2,50,MiddleCaseHeight*0.5]);
    }
}

module MiddleCaseBody() {
    // outline
	translate([46,-2,-25]) {
        difference() {
            union() {
                // case outline
                difference() {
                    minkowski() {
                        sphere(MiddleCaseWallTickness*2);
                        MiddleCaseBodyBase();
                    }
                    minkowski() {
                        sphere(MiddleCaseWallTickness);
                        MiddleCaseBodyBase();
                    }
                    pipe_cut();
                } // -case outline
                // Bearings base
                intersection() {
                    minkowski() {
                        sphere(MiddleCaseWallTickness*2);
                        MiddleCaseBodyBase();
                    }
                    union() {
                        translate([-15,-17,-20])
                            cube([20,40,100]);
                        translate([-95,-15,-20])
                            cube([20,40,100]);
                    }
                } // -Bearings base
                // Gear stand
                GearBearing();
            }
            // mount holes
            translate([-11,-10,-20])
                cylinder(d=MountScrews*1.2,h=100);
            translate([-11,18,-20])
                cylinder(d=MountScrews*1.2,h=100);
            translate([-80,-10,-20])
                cylinder(d=MountScrews*1.2,h=100);
            // Nuts
            color("Red") {
            translate([-11,-10,-8])
                cylinder(d=MountNutDia,h=4,$fn=6);
            translate([-11,18,-8])
                cylinder(d=MountNutDia,h=4,$fn=6);
            translate([-80,-10,-8])
                cylinder(d=MountNutDia,h=4,$fn=6);
            }
            // Pipe holder
            translate([-8,2,25])
                PipeHolderMinus(w=20,bearing=75);
            // main bearing bolt
            translate ([-MiddleCaseWidth/2,-MiddleCaseLength*0.55,-MiddleCaseHeight*0.5])
                cylinder(d=MountScrews*1.2,h=MiddleCaseHeight*2, $fn=16);
            translate ([-MiddleCaseWidth/2,-MiddleCaseLength*0.55,-8])
                cylinder(d=MountNutDia,h=4,$fn=6);

        }
    }
}

module GearBearing() {
    intersection() {
        minkowski() {
            sphere(MiddleCaseWallTickness*2);
            MiddleCaseBodyBase();
        }
        translate ([-MiddleCaseWidth/2,-MiddleCaseLength*0.55,0])
            difference() {
                union() {
                    translate ([0,0,-10])
                        cylinder(d=20,h=MiddleCaseHeight*2);
                    StiffeningRib();
                    translate([0,0,50]) StiffeningRib();
                }
                cylinder(d=MountScrews*1.2,h=MiddleCaseHeight*2);
            }
    }
}

module StiffeningRib() {
    rotate([0,90,45]) cylinder(d=10,h=70);
    rotate([180,90,-45]) cylinder(d=10,h=70);
}

module MiddleCaseBodyBase() {
	hull() {
		translate ([-MiddleCaseWidth/2,-MiddleCaseLength*0.55,0])
			cylinder(h=MiddleCaseHeight,d=MiddleCaseWidth);
		translate ([-MiddleCaseWidth*0.85,-MiddleCaseLength*0.55,0])
			cube([MiddleCaseWidth*0.75,MiddleCaseLength*0.75,MiddleCaseHeight]);
	}
}

module pipe_cut() {
    translate ([-MiddleCaseWidth*0.5,-MiddleCaseLength*0.55,MiddleCaseHeight/2])
    union() {
        hull() {
            translate([-75,0,0])
            rotate ([0,90,0]) 
            cylinder(d=PipeCut, h=75);
            rotate ([0,-90,-20])
            cylinder(d=PipeCut, h=75);
        }
        hull() {
            translate([-75,0,0])
            rotate ([0,90,0]) 
            cylinder(d=PipeCut, h=150);
            translate([-75,-60,0])
            rotate ([0,90,0]) 
            cylinder(d=PipeCut, h=150);
        }
    }
}

MiddleCase();
//GearsMiddleSet();
