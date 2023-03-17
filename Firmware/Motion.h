#ifndef MOTION_H // include guard
#define MOTION_H

#include "Motor.h"
#include "Motion.cpp"

class Motion {
    private:
    Motor motors[6];

    public:
    void forward();
    void turnLeft();
    void turnRight();
    void reverse();
    void brake();
    void sleep();

    Motion();
};


void Motion::forward() {
    for(int i = 0; i < 6; i++) {
        this->motors[i].forward();
    }
}

void Motion::turnLeft() {
    for(int i = 0; i < 6; i++) {
        if (this->motors[i].getMotorID() % 2 == 0) {
            this->motors[i].forward();
        }
        else this->motors[i].reverse();
    }
}

void Motion::turnRight() {
    for(int i = 0; i < 6; i++) {
        if (this->motors[i].getMotorID() % 2 == 0) {
            this->motors[i].reverse();
        }
        else this->motors[i].forward();
    }
}

void Motion::reverse() {
    for (int i = 0; i < 6; i++) {
        this->motors[i].reverse();
    }
}

void Motion::brake() {
    for (int i = 0; i < 6; i++) {
        this->motors[i].brake();
    }
}

void Motion::sleep() {
    for (int i = 0; i < 6; i ++) {
        this->motors[i].sleep();
    }
}

Motion::Motion() {
  // instantiate motors
  Motor frontLeftMotor = new Motor(17, 16, 1);
  Motor frontRightMotor = new Motor(15, 14, 2);
  Motor midLeftMotor = new Motor(24, 25, 3);
  Motor midRightMotor = new Motor(26, 27, 4);
  Motor rearLeftMotor = new Motor(41, 40, 5);
  Motor rearRightMotor = new Motor(39, 38, 6);
}

#endif