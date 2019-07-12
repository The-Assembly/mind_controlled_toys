#include <Servo.h>

Servo myServo;
int ledPin = 13;
void setup() {

  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  myServo.attach(8);
  myServo.write(180);

}


void loop() {
  int val;

  val = Serial.read() - '0';

  while (Serial.available() == 0);


  if (val == 1) {
    myServo.write(180);
    digitalWrite(13, HIGH);

  }

  if (val == 2) {
    digitalWrite(13, HIGH);
    myServo.write(75);

  }
  if (val == 3) {
    myServo.write(0);
    digitalWrite(13, LOW);
  }


}
