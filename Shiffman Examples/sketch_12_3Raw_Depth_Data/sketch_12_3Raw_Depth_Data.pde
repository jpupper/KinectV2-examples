import KinectPV2.KJoint;
import KinectPV2.*;

float a = 0;

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

  // Translate and rotate
  pushMatrix();
  translate(width/2, height/2, -2250);
  rotateY(map(mouseX,0,width,0,2 *PI)); // rotacion se puede poner la variable "a" deinida mas abajo para que rote a velocidad constante.
  // rotateX : rotar en eje X
  int[] depth = kinect.getRawDepthData();

  stroke(map(mouseY,0,height,0,255),255,255); //color del borde
  ////////// funcion mouse: mouseX es la posicion en X del mouse.
  /// map es un conversor de rangos. modifica la variable del primer termino
  // los primeros dos variables el rango que puede tomar la variable
  //los ultimos dos variables el rango al que lo quiero transformar.
  
  
  strokeWeight(5); //ancho del borde
  beginShape(POINTS); // comienzo de una figura :)
  
  
  
 
  int skip = 4;
  for (int x=0; x < kinect.WIDTHDepth;   x+=skip) {
    for (int y=0; y < kinect.HEIGHTDepth; y+=skip) {

      //Formula para convertir el array unidimensional en una matrix
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset];
      PVector point= depthToPointCloudPos(x,y, depth[offset]);
     
     //draw a point
     vertex (point.x,point.y,point.z) ;
    }
  }
  
   endShape();

  popMatrix();

  fill(255);
  text(frameRate, 50, 50);

  // Rotate
 // a += 0.05; // velocidad de rotacion
  
  
}

//calculte the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}