# Ball position control system
The goal of this system is to control the position of the ball on the ramp. The ramp can be raised to +/- 45 degrees from the horizontal.

## How it works

There is a sensor which can accurately detect the position along the ramp. This works by making the ramp out of two metal rods. A voltage is applied to one rod while the other has a resistive strip along its length. The ball is conductive and completes the circuit between the metal rods. This essentially becomes a potentiometer and the position of the ball can be determined from the voltage of read at the second rod.

The system is comprised of 2 control loops. The inner loop is used to control the angle of the ramp while the other loop is used to control the position of the ball. This is done because using a single control loop would result in trying to control a plant with a triple integrator which is more challenging. Using an inner and outer control loop greatly simplifies the process.

In order to design the controllers, a linearized model of the plant was derived. Certain tools needed to be used in order to achieve this. First, the stiction of the motor needed to be quantified and then removed by using a relay with hysteresis. Then linearization was applied to the plant without the stiction. For both the inner and outer controllers, a discretization approach was used. This means that the controller was originally designed in the continuous domain and then mapped into the discrete domain.

The overall control system takes the following form:
![The control system configuration](/images/control_system.png)

The inner controller has the following discrete time transfer function:
$$D_1[z] = {{2z-0.6307} \over {z-0.7261}}$$

This controller was designed in the continuous time domain and then mapping it to discrete time using the SCH rule (zero-order hold) and a sampling frequency of 100 Hz.

The outer controller has the following discrete time transfer function:
$$D_2[z] = -{{1503z^2-2776z+1277} \over {z^2-1.3333z+0.4444}}$$

This controller was designed in the continuous time domain and then mapping it to discrete time using the Trapezoidal rule (Tustin or bilinear transform) and a sampling frequency of 100 Hz.


## Performance

The system performs quite well with a step of magnitude 0.15, the settling time is 2.046 seconds and an overshoot of 2.2%.

The figure below shoes the performance of the system. The blue line is the angle of the ramp, the yellow line is the desired reference position of the ball, and the orange is the actual position of the ball.

![The performance graph](/images/performance.png)

To see it working visually, a simulation of the system is shown below.

![A GIF of the simulated system functioning](/images/ball.gif)
