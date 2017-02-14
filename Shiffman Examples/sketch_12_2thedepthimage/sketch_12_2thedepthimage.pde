import KinectPV2.KJoint;
import KinectPV2.*;


KinectPV2 kinect;
void setup() {
 
  colorMode(HSB);
  size(512, 424, P3D);

  kinect = new KinectPV2(this);

  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.init();
}


void draw() {

  background(0);

  PImage img = kinect.getDepthImage();

  //image(img, 0, 0);
  int skip = 10;
  for (int x=0; x < img.width; x+=skip) {
    for (int y=0; y < img.height; y+=skip) {
      
      //Formula para convertir el array unidimensional en una matrix
      int index = x + y * img.width;
      int col = img.pixels[index];
      
      float b = brightness(img.pixels[index]);
      float z = map(b,0,255,-250,250);
      fill(255-b,255,255-b);
      pushMatrix();
      translate(x,y,z);
      rect(0,0,skip,skip);
      popMatrix();
    }
  }
}