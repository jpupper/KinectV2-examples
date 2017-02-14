import KinectPV2.KJoint;
import KinectPV2.*;


KinectPV2 kinect;

PImage img;
float hue = 0;
void setup() {

  colorMode(HSB);
  size(512, 424, P2D);

  kinect = new KinectPV2(this);
  
img = createImage(kinect.WIDTHDepth,kinect.HEIGHTDepth, RGB);


  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.init();
}


void draw() {

   background(0);
 img.loadPixels(); // carga los pixeles de la imagen
       
       
       hue++;
      if (hue > 255){ //cambia de color con cada frame.
       hue= 0; 
      }
    int[] depth = kinect.getRawDepthData();

  for (int x=0; x < kinect.WIDTHDepth;   x++) {  // 0 - 512
    for (int y=0; y < kinect.HEIGHTDepth; y++) { // 0 -424

      //Formula para convertir el array unidimensional en una matrix
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset]; // 

      float distancia = map(mouseX,0,width,0,3000);
      
      
      
      if (d > distancia/5 && d< distancia){ // distancia entre la cual los objetos se ven amarillos
      img.pixels[offset] = color(hue,255,155); 
      }else{
      img.pixels[offset]= color( 0,0,0);
      }
      
    }
  }
  
  
img.updatePixels(); // actualiza los pixeles de la imagen
image(img, 0,0); // image dibuja la imagen
  
}