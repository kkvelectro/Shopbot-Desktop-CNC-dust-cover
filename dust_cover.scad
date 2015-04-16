/*
Dust cover for Shopbot Desktop CNC

uses dust_cover.dxf for outline shape

2015-04-16
linus@linusnilsson.net
*/

res = 360;
padding = 0.1;

small_outer = 51;
small_inner = 42;

big_outer = 70;
big_inner= 56.15;

base_h = 5;

magnet_d = 13;
magnet_depth = 2.5;



build();

module build() {
    small(28,81,base_h);
    big(102,42,base_h);

    difference() {
        base();
        translate([28,81,-padding])
            cylinder(d=small_inner, h=base_h+padding*2, $fn=res);
        
        translate([102,42,-padding])
            cylinder(d=big_inner, h=base_h+padding*2, $fn=res);
        
        magnet(133,77,base_h-magnet_depth,base_h+padding*2);
        
        magnet(74,87,base_h-magnet_depth,base_h+padding*2);
        
        magnet(61,29,base_h-magnet_depth,base_h+padding*2);
        
    }
    
    bridge();
}

module magnet(x,y,z,h=2) {
    translate([x,y,z])
        cylinder(d=magnet_d, h=h, $fn=res);
}

module small(x,y,z,height = 40) {
    translate([x,y,z]) {
        difference() {
            cylinder(d=small_outer, h=height, $fn=res);
            translate([0,0,-padding]) cylinder(d=small_inner, h=height+padding*2, $fn=res);
        }
    }
}

module big(x,y,z,height = 30) {
    translate([x,y,z]) {
        difference() {
            difference() {
                cylinder(d=big_outer, h=height, $fn=res);
                translate([0,0,height-14]) fastener();
                translate([20,0,height-14]) cube([20,4,15]);
            }
            translate([0,0,-padding]) cylinder(d=big_inner, h=height+padding*2, $fn=res);
        }
    }
}

module fastener(height = 14) {
    difference() {
        cylinder(d=big_outer+5, h=height, $fn=res);
        translate([0,0,-padding]) cylinder(d=big_outer-1, h=height+padding*2, $fn=res);
    }
}

module bridge() {
    translate([37,58,base_h]) rotate([0,0,-30]) cube([35, 4, 13]);
    translate([51,74,base_h]) rotate([0,0,-20]) cube([28, 4, 13]);    
}


module base() {
    extrude(base_h);
}

module extrude(h) {
	linear_extrude(height=h, convexity = 10)
		import(file="dust_cover.dxf");
}