/* A simple example to controll your arduino board via bluetooth of your android smartphone or tablet. Tested with Android 4.
Requirements:
Arduino Board
Bluetooth shield
Android Smartphone (Android 2.3.3 min.)
Ketai library for processing
Jumper D0 to TX
Jumper D1 to RX
Set bluetooth, bluetooth admin and internet sketch permissions in processing.
Processing Code:
*/

//required for BT enabling on startup

import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

PFont fontMy;
boolean bReleased = true; //no permament sending when finger is tap
KetaiBluetooth bt;
boolean isConfiguring = true;
String info = "";
KetaiList klist;
ArrayList devicesDiscovered = new ArrayList();

float aanButtonWidth = 50;
float aanButtonHeight = 50;
float aanButtonX = width - aanButtonWidth - 100;
float aanButtonY = height - aanButtonHeight - 25;
float uitButtonWidth = 50;
float uitButtonHeight = 50;
float uitButtonX = width - uitButtonWidth - 25;
float uitButtonY = height - uitButtonHeight - 25;
float arduinoDataPosX = width - 275;
float arduinoDataPosY = 400;

float modusButtonWidth = 100;
float modusButtonHeight = 100;
float modus1ButtonX = 15;
float modus1ButtonY = 15;
float modus2ButtonX = 130;
float modus2ButtonY = 15;
float modus3ButtonX = 245;
float modus3ButtonY = 15;
float modus0ButtonX = 360;
float modus0ButtonY = 15;

float upButtonWidth = 100;
float upButtonHeight = 150;
float upButtonX = 190;
float upButtonY = 230;

float downButtonWidth = 100;
float downButtonHeight = 150;
float downButtonX = 190;
float downButtonY = 520;

float leftButtonWidth = 150;
float leftButtonHeight = 100;
float leftButtonX = 20;
float leftButtonY = 400;

float rightButtonWidth = 150;
float rightButtonHeight = 100;
float rightButtonX = 310;
float rightButtonY = 400;

float middleButtonWidth = 100;
float middleButtonHeight = 100;
float middleButtonX = 190;
float middleButtonY = 400;


//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************

void onCreate(Bundle savedInstanceState) {
 super.onCreate(savedInstanceState);
 bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
 bt.onActivityResult(requestCode, resultCode, data);
}

void setup() {
 //size(width, height);
 frameRate(10);
 orientation(PORTRAIT);
 background(0);
 
 //start listening for BT connections
 bt.start();
 //at app start select device…
 isConfiguring = true;
 //font size
 fontMy = createFont("SansSerif", 20);
 textFont(fontMy);
}

void draw() {
 //at app start select device
 if (isConfiguring)
 {
  ArrayList names;
  background(78, 93, 75);
  klist = new KetaiList(this, bt.getPairedDeviceNames());
  isConfiguring = false;
 }
 else
 {
  background(0,50,0);
  if((mousePressed) && (bReleased == true))
  {
 //send with BT
  byte[] data = {'s','w','i','t','c','h','\r'};
  bt.broadcast(data);
 //first tap off to send next message
  bReleased = false;
  }
  if(mousePressed == false)
  {
  bReleased = true; //finger is up
  }
  fill(0,255,0);
  rect(aanButtonX,aanButtonY,aanButtonWidth,aanButtonHeight);
  fill(255);
  text("Led AAN",aanButtonX + (aanButtonWidth*0.1),aanButtonY+ (aanButtonHeight*0.7));
  
  fill(255,0, 0);
  rect(uitButtonX,uitButtonY,upButtonWidth,uitButtonHeight);
  fill(255);
  text("Led UIT",uitButtonX + (uitButtonWidth*0.1),uitButtonY+ (uitButtonHeight*0.7));
  
  rect(modus1ButtonX, modus1ButtonY, modusButtonWidth, modusButtonHeight);
  rect(modus2ButtonX,modus2ButtonY,modusButtonWidth,modusButtonHeight);
  rect(modus3ButtonX,modus3ButtonY,modusButtonWidth,modusButtonHeight);
  rect(modus0ButtonX,modus0ButtonY,modusButtonWidth,modusButtonHeight);
  
  
  rect(upButtonX,upButtonY,upButtonWidth,upButtonHeight);
  rect(downButtonX,downButtonY,downButtonWidth,downButtonHeight);
  rect(leftButtonX,leftButtonY,leftButtonWidth,leftButtonHeight);
  rect(rightButtonX,rightButtonY,rightButtonWidth,rightButtonHeight);
  rect(middleButtonX,middleButtonY,middleButtonWidth,middleButtonHeight);
  
  
  if(mousePressed){
    if(mouseX > aanButtonX && 
       mouseX < aanButtonX + aanButtonWidth && 
       mouseY > aanButtonY && 
       mouseY < aanButtonY + aanButtonHeight){
         println("AAN button!");
         byte[] data = {'L'};
         bt.broadcast(data);
    }
    
    if(mouseX > uitButtonX && 
       mouseX < uitButtonX + uitButtonWidth && 
       mouseY > uitButtonY && 
       mouseY < uitButtonY + uitButtonHeight){
         println("UIT button");
         //port.write("k"); 
         byte[] data = {'K'};
         bt.broadcast(data);
    }
    
    if(mouseX > upButtonX && 
       mouseX < upButtonX + upButtonWidth && 
       mouseY > upButtonY && 
       mouseY < upButtonY + upButtonHeight){
         println("UP button");
         //port.write("W"); 
         byte[] data = {'W'};
         bt.broadcast(data);
    }
    
    if(mouseX > downButtonX && 
       mouseX < downButtonX + downButtonWidth && 
       mouseY > downButtonY && 
       mouseY < downButtonY + downButtonHeight){
         println("DOWN button");
         //port.write("S"); 
         byte[] data = {'S'};
         bt.broadcast(data);
    }
    if(mouseX > leftButtonX && 
       mouseX < leftButtonX + leftButtonWidth && 
       mouseY > leftButtonY && 
       mouseY < leftButtonY + leftButtonHeight){
         println("LEFT button");
         //port.write("A"); 
         byte[] data = {'A'};
         bt.broadcast(data);
    }
    if(mouseX > rightButtonX && 
       mouseX < rightButtonX + rightButtonWidth && 
       mouseY > rightButtonY && 
       mouseY < rightButtonY + rightButtonHeight){
         println("RIGHT button");
         //port.write("D"); 
         byte[] data = {'D'};
         bt.broadcast(data);
    }
    if(mouseX > middleButtonX && 
       mouseX < middleButtonX + middleButtonWidth && 
       mouseY > middleButtonY && 
       mouseY < middleButtonY + middleButtonHeight){
         println("MIDDLE button");
         //port.write("F");
         byte[] data = {'F'}; 
         bt.broadcast(data);
    }
     
    if(mouseX > modus1ButtonX && 
       mouseX < modus1ButtonX + modusButtonWidth && 
       mouseY > modus1ButtonY && 
       mouseY < modus1ButtonY + modusButtonHeight){
         println("MODUS 1 button");
         //port.write("1");
         byte[] data = {'1'}; 
         bt.broadcast(data);
    }
    if(mouseX > modus2ButtonX && 
       mouseX < modus2ButtonX + modusButtonWidth && 
       mouseY > modus2ButtonY && 
       mouseY < modus2ButtonY + modusButtonHeight){
         println("MODUS 2 button");
         //port.write("2"); 
         byte[] data = {'2'};
         bt.broadcast(data);
    }
    if(mouseX > modus3ButtonX && 
       mouseX < modus3ButtonX + modusButtonWidth && 
       mouseY > modus3ButtonY && 
       mouseY < modus3ButtonY + modusButtonHeight){
         println("MODUS 3 button");
         //port.write("3"); 
         byte[] data = {'3'};
         bt.broadcast(data);
    }
    if(mouseX > modus0ButtonX && 
       mouseX < modus0ButtonX + modusButtonWidth && 
       mouseY > modus0ButtonY && 
       mouseY < modus0ButtonY + modusButtonHeight){
         println("MODUS 0 button");
         //port.write("0"); 
         byte[] data = {'0'};
         bt.broadcast(data);
    }
  } 
 //print received data
  fill(255);
  noStroke();
  textAlign(LEFT);
  text(info, 20, 150);
 }
}

void onKetaiListSelection(KetaiList klist) {
 String selection = klist.getSelection();
 bt.connectToDeviceByName(selection);
 //dispose of list for now
 klist = null;
}

//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data) {
 if (isConfiguring)
 return;
 //received
 info += new String(data);
 //clean if string to long
 if(info.length() > 150)
 info = "";
}

// Arduino+Bluetooth+Processing 
// Arduino-Android Bluetooth communication
