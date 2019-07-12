// Import the libraries and dependencies
import oscP5.*;
import java.awt.*;
import processing.serial.*;
OscP5 oscP5;
Robot bob;
float currentAttention;
float threshold = 70.0;
float threshold1 = 40.0;
float currentSignal;
PImage signal;
PImage attentionOK;
PImage lessAttention;
PImage Almost;
// The setup function runs once when you start your application
Serial myPort;
void setup() {
  size(1240, 600);
  oscP5 = new OscP5(this, "192.168.56.1", 7771); // Start listening for incoming messages at port 7771 
  signal = loadImage("green.png");
  attentionOK = loadImage("Concentrating.png");
  lessAttention = loadImage("notConcentrating.png");
  println(Serial.list());
  Almost = loadImage("Almost.png");
  myPort = new Serial(this, Serial.list()[0], 9600);

  try { // Try and create a new robot named bob
    bob = new Robot();
  } 
  catch (AWTException e) { // If there is an error, print it out to the console
    e.printStackTrace();
  }
}

// The draw function runs over and over again until you close the application
void draw() {
  if (currentAttention >threshold) {
    myPort.write('1');
    background(attentionOK);
    textSize(32);
    fill(50);
    text("the signal quality is:" + currentSignal, 100, 34);
    text("the first threshold is:" + threshold1, 100, 70); 
    text("the second threshold is:" + threshold, 100, 108); 
    text("the attention is:" + currentAttention, 100, 142);
  }
  if (currentAttention < threshold && currentAttention> threshold1) {
    background(Almost);
    myPort.write('2');

    textSize(32);
    fill(50);
    text("the signal quality is:" + currentSignal, 100, 34);
    text("the first threshold is:" + threshold1, 100, 70); 
    text("the second threshold is:" + threshold, 100, 108); 
    text("the attention is:" + currentAttention, 100, 142);
  }
  if (currentAttention < threshold1) {
    background(lessAttention);
    myPort.write('3');
    textSize(32);
    fill(50);
    text("the signal quality is:" + currentSignal, 100, 34);
    text("the first threshold is:" + threshold1, 100, 70); 
    text("the second threshold is:" + threshold, 100, 108); 
    text("the attention is:" + currentAttention, 100, 142);
  }
}

void oscEvent(OscMessage theMessage) {
  // Print the address and typetag of the message to the console
  // println("OSC Message received! The address pattern is " + theMessage.addrPattern() + ". The typetag is: " + theMessage.typetag());
  //println(theMessage);
  // Check for Attention messages only
  if (theMessage.checkAddrPattern("/attention") == true) {
    currentAttention = theMessage.get(0).floatValue();
    println("Your attention is at: " + currentAttention);
  }  
  if (theMessage.checkAddrPattern("/signal") == true) {
    currentSignal = theMessage.get(0).floatValue();
    println("Signal is at: " + currentSignal);
  }
}
