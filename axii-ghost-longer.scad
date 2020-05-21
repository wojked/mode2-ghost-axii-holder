/* [OFFSET] */
OFFSET = 12; // [5:20]

/* [HIDDEN] */
$fn = 128;

axii_patched_sides();

module axii(){
    width = 20;
    rotate([90,0,0])
    import("axii.stl", convexity=3);
}


module axii_patched_sides(){
    difference(){
        axii();
        left_box();
        right_box();
    }
    
    translate([0,-OFFSET,0])
    union(){

        patched_left();
        
        patched_right();
    }
    
    left_bridge();
    
    right_bridge();
}

module axii_box(){
    color("blue", 0.5)
    cube([8,10,height], true);    
}

module box(){
    height = 5;
    
    color("red", 0.5)
    translate([0,-0.2,height/2])
    cube([8,8,height], true);

}

module left_box(){
    x_offset = 25;    
    translate([x_offset,0,0])
    box();
}

module right_box(){
    x_offset = -0.5;
    translate([x_offset,0,0])    
    box();
}

module bridge(offset1, offset2){
    thickness = 5;
    
    hull(){
        //near axii
        color("blue", 0.5)
        translate([4 + offset1,1.2,thickness/2])
        cube([1,5.5,thickness], true);            
        
        //near poles
        color("green", 0.5)        
        translate([2 + offset2,-(OFFSET-3),thickness/2])
        cube([4,0.5,thickness], true);              
    }

    
}

module left_bridge(){    
    x_offset = 10;
    translate([x_offset,0,0])        
    bridge(7, 11);
}

module right_bridge(){
    x_offset = -0.5;
    translate([x_offset,0,0])        
    bridge(0, 0);
}

module patched_left(){
    intersection(){
        axii();
        left_box();
    }
}

module patched_right(){
    intersection(){
        axii();
        right_box();
    }
}

