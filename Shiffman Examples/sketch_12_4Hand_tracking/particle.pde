class Particle {

  PVector pos;
  PVector angle;
  
  PVector speed;
  PVector accel;
  
  
  
  float size;
  float size2;

  float life;
  float life_speed;
  float Bsize;

  int npoints;
  color figura;
  color stroke;

  //Este booleano indica si se utilizara una estrella o un poligono. 
  //Depende de como este hecho el constructor, si se inicializa con un solo "size" sera un poligono
  // Si no , será una estrella.

  boolean starorpolygon;

  Particle(PVector _pos) {


    pos = _pos;
    size = 10;
    life = 255;
    life_speed = 15;
    
    angle = new PVector(0,0);
    
    size = random(5,15);
    Bsize = 5;

    life = 255;
    life_speed = random(1,5);

    figura = color(random(150,255),random(150,255),random(50,255));
    stroke = color(255,0,255,40);

    starorpolygon = true;

    npoints = parseInt(random(3,30));
    
    speed = new PVector(0,0);
    accel = new PVector(random(-0.02,0.02),random(0.01,2));
  }

  //CONSTRUCTOR CON FORMA DE POLIGONO
  Particle(
    
    PVector _pos, 
    float _size, int _npoints, float _Bsize, 
    float _life, float _life_speed, 
    color _figura, color _stroke,
    PVector _angle) {

    pos = _pos;
    angle = _angle;
    
    
    size = _size;
    Bsize = _Bsize;

    life = _life;
    life_speed = _life_speed;

    figura = _figura;
    stroke = _stroke;

    starorpolygon = true;

    npoints = _npoints;
    
    
  }

  //CONSTRUCTOR PARA ESTRELLA
  Particle(PVector _pos, 
    float _size, float _size2, int _npoints, 
    float _Bsize, 
    float _life, float _life_speed, 
    color _figura, color _stroke,
    PVector _angle) {


    pos = _pos;
    
    size = _size;
    size2 = _size2;
    
    Bsize = _Bsize;

    life = _life;
    life_speed = _life_speed;

    figura = _figura;
    stroke = _stroke;
    angle = _angle;
    
    starorpolygon = false;

    npoints = _npoints;
    
    
  }

  void run() {

    design();
    update();
  }

  void update() {
 
    speed.add(accel);
    pos.add(speed);
    
   
    life-= life_speed;
    design();
    
    pushMatrix();
    
    float angledir = angle.heading();
    translate(pos.x,pos.y);
    rotate(angledir+PI/2);
    //shape(forma, pos.x, pos.y);
    //ellipse(pos.x,pos.y,size,size);
    if (starorpolygon) {
      polygon(0, 0, size, npoints);
    } else {
      star(0, 0, size, size2, npoints);
    }
    popMatrix();
  }

  //DISEÑO
  void design() {

    fill(figura, life);
    stroke(stroke, life);
    strokeWeight(Bsize);
  }

  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;

    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }


  boolean isDead() {

    if (life < 0) {
      return true;
    } else 
    return false;
  }
}

//Chobi 0:
class P_Pepe extends Particle{
  
 
   P_Pepe(PVector _pos,PVector _angle_speed,float _size){
       super(  
              _pos, 
              _size, _size/2,2,
              1,
              255, 15, 
              color(random(100, 150), random(150, 255), random(150, 255)), 
              color(255, 0, 255),
              _angle_speed); 
  }
}

//Chobi 1:
class P_Juan extends Particle{
  
  

   P_Juan(PVector _pos,PVector _angle_speed,float _size){
      
     
       super(  
              _pos, 
              _size, _size/2,2,
              1,
              255, 15, 
              color(255, random(150, 255), random(0, 255)), 
              color(255, 0, 255),
              _angle_speed); 
  }
}

//Chobi 2:
class P_Manolo extends Particle{
  
  

   P_Manolo(PVector _pos,PVector _angle_speed,float _size){
      
     
       super(  
              _pos, 
              _size*2, _size/2,2,
              1,
              255, 15, 
              color(random(150, 170), random(150, 255), random(150, 255)), 
              color(255, 0, 255),
              _angle_speed); 
  }
}

//Chobi 3:
class P_Pampero extends Particle{
  
  

   P_Pampero(PVector _pos,PVector _angle_speed,float _size){
      
     
       super(  
              _pos, 
              60, 60,2,
              1,
              255, 15, 
              color(100, random(150, 255), random(150, 255)), 
              color(255, 0, 255),
              _angle_speed); 
  }
  
}