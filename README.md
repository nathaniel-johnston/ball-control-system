# Ball position control system
The goal of this system is to control the position of the ball on the ramp. The ramp can be raised to +/- 45 degrees from the horizontal.

## How it works

There is a sensor which can accurately detect the position along the ramp. This works by making the ramp out of two metal rods. A voltage is applied to one rod while the other has a resistive strip along its length. The ball is conductive and completes the circuit between the metal rods. This essentially becomes a potentiometer and the position of the ball can be determined from the voltage of read at the second rod.

The system is comprised of 2 control loops. The inner loop is used to control the angle of the ramp while the other loop is used to control the position of the ball. This is done because using a single control loop would result in trying to control a plant with a triple integrator which is more challenging. Using an inner and outer control loop greatly simplifies the process.

In order to design the controllers, a linearized model of the plant was derived. Certain tools needed to be used in order to achieve this. First, the stiction of the motor needed to be quantified and then removed by using a relay with hysteresis. Then linearization was applied to the plant without the stiction. For both the inner and outer controllers, a discretization approach was used. This means that the controller was originally designed in the continuous domain and then mapped into the discrete domain.

The overall control system takes the following form:
![The control system configuration](/images/control_system.png)
