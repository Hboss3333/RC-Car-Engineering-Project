// ============================================================
//  1:10 SCALE RC CAR BODY SHELL - Parametric OpenSCAD
//  Open in OpenSCAD (free, openscad.org), tweak the params
//  below, press F6 to render, then File > Export > STL to print.
// ============================================================

/* [Main Dimensions - mm] */
body_length   = 320;   // nose to tail
body_width    = 190;   // widest point (over wheel arches)
body_height   = 70;    // deck height, not counting canopy
wall          = 2.4;   // shell thickness - PETG, 3 perimeters
nose_taper    = 60;    // how far back the nose tapers in
tail_taper    = 40;    // how far forward the tail tapers in

/* [Wheel Wells] */
wheel_dia     = 100;   // outer tire diameter, clearance cut
wheel_width   = 45;    // tire width, clearance cut
wheelbase     = 260;   // front axle to rear axle
track_width   = 180;   // left wheel center to right wheel center
arch_lift     = 18;    // how far the arch cuts up into the body

/* [Canopy / Electronics Hatch] */
canopy_len    = 140;
canopy_width  = 110;
canopy_height = 30;
canopy_setback= 40;    // distance from body center-front to canopy front

/* [Cooling Vents over ESC/motor] */
vent_count    = 6;
vent_len      = 30;
vent_width    = 4;
vent_gap      = 6;

/* [Mounting Posts - screw down into chassis] */
post_dia      = 6;
post_height   = 10;
post_hole_dia = 2.6;   // pilot hole for M3 self-tap screw

$fn = 48; // smoothness

// ------------------------------------------------------------
// MAIN OUTER SHAPE - built from a hull of scaled spheres
// so nose/tail/sides taper smoothly, no boolean-heavy loft
// ------------------------------------------------------------
module outer_shape(l, w, h) {
    nose_x  = -l/2;
    tail_x  =  l/2;
    hull() {
        // nose point (narrow, low)
        translate([nose_x + 10, 0, h*0.35])
            sphere(d = 14);
        // front shoulders (wide point starts here)
        translate([nose_x + nose_taper, 0, h*0.5])
            scale([1, w/40, h/40])
                sphere(d = 40);
        // rear shoulders
        translate([tail_x - tail_taper, 0, h*0.5])
            scale([1, w/40, h/40])
                sphere(d = 40);
        // tail point
        translate([tail_x - 8, 0, h*0.4])
            sphere(d = 16);
    }
}

// ------------------------------------------------------------
// HOLLOW SHELL - outer shape minus an inset copy of itself
// ------------------------------------------------------------
module shell() {
    difference() {
        outer_shape(body_length, body_width, body_height);
        translate([0,0,wall])
            scale([
                (body_length - wall*3)/body_length,
                (body_width  - wall*3)/body_width,
                (body_height - wall*1.2)/body_height
            ])
                outer_shape(body_length, body_width, body_height);
        // open the bottom so it sits over the chassis
        translate([0,0,-body_height])
            cube([body_length*1.2, body_width*1.2, body_height], center = true);
    }
}

// ------------------------------------------------------------
// WHEEL ARCH CUTOUTS - clearance so wheels can turn/travel
// ------------------------------------------------------------
module wheel_arch_cuts() {
    for (fx = [-wheelbase/2, wheelbase/2])
        for (ty = [-track_width/2, track_width/2])
            translate([fx, ty, arch_lift])
                rotate([90,0,0])
                    cylinder(d = wheel_dia + 14, h = wheel_width + 20, center = true);
}

// ------------------------------------------------------------
// COOLING VENTS - slot array over the motor/ESC bay
// ------------------------------------------------------------
module vents() {
    start_y = -((vent_count-1)/2) * (vent_width + vent_gap);
    for (i = [0 : vent_count-1])
        translate([body_length*0.12, start_y + i*(vent_width+vent_gap), body_height])
            cube([vent_len, vent_width, wall*3], center = true);
}

// ------------------------------------------------------------
// ELECTRONICS CANOPY / HATCH - separate printable piece,
// sits in a recess so it's removable for battery/board access
// ------------------------------------------------------------
module canopy() {
    translate([-body_length/2 + canopy_setback + canopy_len/2, 0, body_height])
        difference() {
            outer_shape(canopy_len, canopy_width, canopy_height*2);
            translate([0,0,wall])
                scale([
                    (canopy_len - wall*3)/canopy_len,
                    (canopy_width - wall*3)/canopy_width,
                    1
                ])
                    outer_shape(canopy_len, canopy_width, canopy_height*2);
            translate([0,0,-canopy_height*2])
                cube([canopy_len*1.2, canopy_width*1.2, canopy_height*2], center = true);
        }
}

// ------------------------------------------------------------
// MOUNTING POSTS - print bosses on the underside for chassis screws
// ------------------------------------------------------------
module mounting_posts() {
    for (fx = [-wheelbase/2 - 20, 0, wheelbase/2 + 20])
        for (ty = [-body_width/2 + 25, body_width/2 - 25])
            translate([fx, ty, 0])
                difference() {
                    cylinder(d = post_dia, h = post_height);
                    cylinder(d = post_hole_dia, h = post_height + 1);
                }
}

// ------------------------------------------------------------
// FULL ASSEMBLY
// ------------------------------------------------------------
module rc_car_body() {
    difference() {
        union() {
            shell();
            mounting_posts();
        }
        wheel_arch_cuts();
        vents();
    }
}

// Render: body shell + separate canopy laid beside it for printing
rc_car_body();
translate([0, body_width, 0]) canopy();

// To print the canopy as its own STL, comment out rc_car_body()
// above and export just canopy() by itself.
