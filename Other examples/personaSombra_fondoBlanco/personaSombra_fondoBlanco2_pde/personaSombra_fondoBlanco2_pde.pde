import KinectPV2.*;
import spout.*;



KinectPV2 kinect;
Spout spout;


boolean foundUsers = false;

void setup() {
 size(1024, 848, P3D); // 1024,424
//textureMode(NORMAL);

  kinect = new KinectPV2(this);

  kinect.enableDepthImg(true);
  kinect.enableBodyTrackImg(true);

  kinect.init();
  
  // CREATE A NEW SPOUT OBJECT
  spout = new Spout(this);
  spout.createSender("Spout Processing");
}

void draw() {
  background(0);


 //image(kinect.getDepthImage(), 0, 0); //prueba
 image(kinect.getBodyTrackImage(), 0, 0, 640, 360);

    //raw body data 0-6 users 255 nothing
  int [] rawData = kinect.getRawBodyTrack();

  foundUsers = false;
  for(int i = 0; i < rawData.length; i+=5){
    if(rawData[i] != 255){
     //found something
     foundUsers = true;
     break;
    }
    
 
  }
  
  
 spout.sendTexture();
  //display the number of users detected 
 // fill(255, 0, 0 );
 // text(kinect.getNumOfUsers(), 50, 50);
  //text("Found User: "+foundUsers, 50, 70);
  //text(frameRate, 50, 90);

}



  
 //
//void mousePressed() {
  //println(frameRate);
  ///saveFrame();
//}