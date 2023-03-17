#ifndef MOTOR_H
#define MOTOR_H
#include <Arduino.h>

class Motor {
    private:
    int p1;
    int p2;
    int motorID;

    public:
    void sleep();
    void forward();
    void reverse();
    void brake();

    Motor(int p1, int p2, int motorID);

    void setP1(int p1);
    void setP2(int p2);
    void setMotorID(int motorID);
    int getP1();
    int getP2();
    int getMotorID();
};

void Motor::sleep() {
  digitalWrite(p1, 0);
  digitalWrite(p2, 0);
}

void Motor::forward() {
    digitalWrite(p1, 1);
    digitalWrite(p2, 0);
}

void Motor::reverse() {
    digitalWrite(p1, 0);
    digitalWrite(p2, 1);
}

void Motor::brake() {
    digitalWrite(p1, 1);
    digitalWrite(p2, 1);
}

Motor::Motor(int p1, int p2, int motorID) {
    this->p1 = p1;
    this->p2 = p2;
    this->motorID = motorID;
}


/*
// ChatGPT suggestion. May be something wrong with my constructor, or default constructor
Motor::Motor(int p1, int p2, int motorID) : p1(p1), p2(p2), motorID(motorID) {
}
*/

// getters and setters
void Motor::setP1(int p1) {
    this->p1 = p1;
}

void Motor::setP2(int p2) {
    this->p2 = p2;
}

void Motor::setMotorID(int motorID) {
    this->motorID = motorID;
}

int Motor::getP1() {
    return p1;
}

int Motor::getP2() {
    return p2;
}

int Motor::getMotorID() {
    return motorID;
}

#endif