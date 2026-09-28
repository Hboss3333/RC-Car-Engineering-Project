# RC Car Engineering Project

A custom RC car engineering project built around 3D-printed mechanical parts, small DC motors, off-the-shelf electronics, and iterative testing.

## The idea

The goal is to design and build an RC car from individual components instead of starting with a complete RC-car kit. We are treating it like a real engineering project: measure the hardware we actually have, design parts around those measurements, 3D-print prototypes, test them, fix what does not work, and keep improving the design.

The car is planned around a modular 3D-printed chassis/body with replaceable mechanical parts. The drivetrain uses small 3–6 V DC motors. One of the first problems we ran into was that the available wheels did not fit the motor shafts. The motor shaft is not a simple round shaft, so a custom 3D-printable adapter was designed to connect the motor to the wheel.

The blueprint also leaves room for the project to grow. After we get a reliable manually controlled RC car working, later versions can add more advanced electronics, a small onboard computer, and a camera for sensing/vision experiments. The important rule is to get the basic car driving reliably first, then add the more advanced features one at a time.

## Current design goals

- 3D-printed chassis/body
- Four-wheel layout
- Front steering
- Two 3–6 V rear drive motors, one per rear wheel, with supported wheel axles
- Low, centered battery placement
- Separate mounting locations for receiver, ESC/motor controller, and steering servo
- Custom motor-to-wheel adapters where needed
- Modular parts that can be redesigned without reprinting the entire car
- Future space for an onboard computer and camera
- Physical power switch/manual stop
- Test manual driving before adding autonomous control

## Repository layout

```text
CAD/
  lego_motor_adapter_2_larger_sockets.stl
  rc_car_body.stl

Blueprints/
  rc_car_blueprint.svg
```

## CAD files

### `lego_motor_adapter_2_larger_sockets.stl`

Two different motor-to-LEGO cross-axle test adapters for the planned two-motor rear drive. The shaft sockets are provisional (4.7 × 3.0 mm and 5.2 × 3.4 mm). Print at 100% scale, test gently with motors unplugged, then make two matching final adapters once the fit is known. The LEGO cross-axle end is unchanged from the previous test. The motor sockets are each widened by 0.2 mm in both dimensions. The body was printed at 70% scale.

### `rc_car_body.stl`

The printable RC car body model currently being used for the project. This STL replaces the earlier OpenSCAD source file so the repository now contains the actual printable mesh.

## Blueprint

### `rc_car_blueprint.svg`

A concept blueprint showing the planned layout of the chassis, steering, drivetrain, battery, receiver, ESC, future computer, camera, and removable body shell.

The blueprint is a concept drawing rather than a final manufacturing drawing. Exact dimensions and mounting holes should be adjusted to match the real components being used.

## Development process

1. Measure the actual motors, shafts, wheels, electronics, and fasteners.
2. Design or modify the CAD parts.
3. 3D-print test pieces before committing to large prints.
4. Test mechanical fit and wheel alignment.
5. Assemble the basic drivetrain and steering.
6. Wire the battery, motor controller/ESC, receiver, and servo.
7. Test the car at low speed.
8. Fix mechanical/electrical problems and update the CAD.
9. Add the printed body.
10. Only after manual driving is reliable, experiment with onboard computing/camera features.

## Status

Work in progress. The design is expected to change as printed parts and real hardware are tested.
