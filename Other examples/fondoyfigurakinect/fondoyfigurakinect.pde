/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/

 KinectPV2, Kinect for Windows v2 library for processing

 Skeleton color map example.
 Skeleton (x,y) positiogns are mapped to match the color Frame
 */

import KinectPV2.KJoint;
import KinectPV2.*;
import spout.*;



KinectPV2 kinect;
Spout spout;


ParticleSystem PDer;
ParticleSystem Pizq;


int Ptype = 1 ;

float zVal = 300;
float rotX = PI;

PVector Posder,Posizq;
void setup() {
  size(512, 424, P3D);

  kinect = new KinectPV2(this);

  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);
  kinect.init();
  
  
  
  colorMode(HSB);
  rectMode(CENTER);

   spout = new Spout(this);
}

void draw() {
   background(0);

 // tint(255,255,255);
  image(kinect.getDepthMaskImage(), 0, 0);

  spout.sendTexture();
  
    
  fill(0,255, 0);
  text(frameRate, 50, 50);
}



/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */