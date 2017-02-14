import KinectPV2.KJoint;
import KinectPV2.*;


KinectPV2 kinect;
ParticleSystem PS;

PImage img;
float hue = 0;
void setup() {

  colorMode(HSB);
  size(512, 424, P2D);

  kinect = new KinectPV2(this);

  img = createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth, RGB);


  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.init();
  
  PS = new ParticleSystem(new PVector(width/2,height/2),20);
}


void draw() {

  background(0);
  
  
  img.loadPixels(); // carga los pixeles de la imagen

  
  hue++;
  if (hue > 255) { //cambia de color con cada frame.
    hue= 0;
  }
  int[] depth = kinect.getRawDepthData();
  
  
 int record =4500;
 int rx=0;
 int ry=0;
 
 
  //float distanciax = map(mouseX, 0, width, 0, 1000);
  //float distanciaY = map(mouseY, 0, height, 0, 1000);
  //println("X ", distanciax, "Y ", distanciaY);
  PImage DImg = kinect.getDepthImage();
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for (int x=0; x < kinect.WIDTHDepth; x++) {  // 0 - 512
    for (int y=0; y < kinect.HEIGHTDepth; y++) { // 0 -424

      //Formula para convertir el array unidimensional en una matrix
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset]; // 



      if (d >0  && d< 800) { // distancia entre la cual los objetos se ven amarillos
        img.pixels[offset] = color(hue, 255, 155);
        
        sumX+= x;
        sumY+= y;
        totalPixels++;
        
        if (d< record) {
        record=d;
        rx=x;
        ry=y;
        }
        
        
      } else {
        img.pixels[offset]= DImg.pixels[offset]; // sino pone el pixel del color de la depth image (Escala de grises segun profundidad)
        
      }
    }
  }


  img.updatePixels(); // actualiza los pixeles de la imagen
  image(img, 0, 0); // image dibuja la imagen

  
  ellipse (rx,ry, 32,32);
  //PS.display(totalPixels*0.005);
  //float avgX = sumX / totalPixels;
  //float avgY = sumY / totalPixels;
  //PS.setPos(avgX,avgY);
  //fill(255,220,255,150);
  //ellipse(avgX,avgY,20+totalPixels*0.005,20+totalPixels*0.005);
}