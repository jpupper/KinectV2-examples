class Particle{
   
  PVector pos;
  PVector speed;
  PVector accel;
  
  float rdmx,rdmy;   
     
  float stm;
  
  float vibr;
    
  float amp;
  float angle;
  float Aspeed;
  
  float size;
  float lifespan;
  float lifespanspeed;
  float mass;
  
  color colorfig ;
  float hue,sat,bri;
  
  Particle(PVector _pos,
           PVector _speed,
           PVector _accel,
           float _rdmx,float _rdmy,
           float _amp,
           float _size,
           float _hue,float _sat, float _bri,
           float _lifespanspeed){
   
    mass = 1;
    
      
    pos = _pos;
    speed = _speed;
    accel = _accel;
    rdmx = _rdmx; rdmy =_rdmy;
    size = _size;
    
    amp = _amp;
    Aspeed = 0.001;
    
    hue = _hue;
    sat = _sat;
    bri = _bri;
    
    lifespanspeed = _lifespanspeed;
    lifespan = 255;
    stm = 8;
    
  }
  
   Particle(PVector _pos){
   
    mass = 1;
    
      
    pos = _pos;
    speed = new PVector(0,0);
    accel = new PVector(0,0.1);
    rdmx = 0.1; rdmy = 0.1;
    size = 10;
    
    amp = 0;
    Aspeed = 0.001;
    
    hue = 150;
    sat = 150;
    bri = 255;
    
    lifespanspeed = 5;
    lifespan = 255;
    stm = 8;
    
  }
  void run(){
    
   display();
   update();
  }
  
  void applyForce(PVector _f){
    
    _f.div(mass);
     accel.add(_f);
  }
  
  
  void display(){
     pushMatrix();
     translate(pos.x,pos.y);
     rotate(speed.heading());
     design();                 
     popMatrix();
  }
  
  
  void update(){
   
    //applyForce(new PVector(map(mouseX,0,width,-0.5,0.5),map(mouseY,0,height,-0.5,0.5)));
    //atractTomouse();
    
    addRandom(rdmx,rdmy);
   
    speed.add(accel);
    speed.limit(5);
     
     
    pos.add(speed);
    lifespan -=lifespanspeed;
    
  }
  void angular(){
    
    angle+=0.05;
    PVector oscilator = new PVector(10 * sin(angle),10 * cos(angle));
    oscilator.normalize();
    pos.add(oscilator);
    
    
  }
  void atractTomouse(){
    if(mousePressed){
    PVector mouse = new PVector (mouseX,mouseY);
    PVector dir = PVector.sub(mouse,pos);
    
    dir.normalize();
    dir.mult(stm);
    speed.add(dir);
    }
  }
  
  boolean isDead(){
   if (lifespan < 0){
    return true; 
   }
   else {
    return false; 
   }
  }
  void design(){
        /*triangle( 0,-size,
               size,0,
               0,size
             );*/
     stroke(1,lifespan);
     strokeWeight(2);
     noStroke();
     fill(hue,sat,bri,lifespan);
     star(0,0,size*2,size-size/4,20);        
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
  
 
  void addRandom(float _rdmx,float _rdmy){
      PVector rdm = PVector.random2D();
      rdm.x = rdm.x * _rdmx; 
      rdm.y = rdm.y * _rdmy;
      
      //rdm.normalize();
      
      speed.add(rdm);    
  }
}


class Fire extends Particle{
  
  float hue = 0;
  float chispi;
  float angle;
  
  PVector origin;
  Fire(PVector _pos){
     super(new PVector(random(_pos.x-10,_pos.x+10),_pos.y),
           new PVector(0,random(-0.4,0)),
           new PVector(0,random(-0.03,0)),
           0,0.01,
           0,
                            random(10,25),
                            0,random(255,255),random(200,255),
                            2);
     origin = _pos;             
   }
   
   void design(){
         
         hueSpread();
         
         strokeWeight(2);
         noStroke();
         fill(hue,sat,bri,lifespan);
         for(int i=0; i<2; i++){
           ellipse(0 ,0 + 20 * sin(angle *i),size-chispi,size-chispi);
         }
         //star(0,0,size*2,size-size/4,20);        
   }
   
   void hueSpread(){
     hue+=0.3;
     angle+=0.1;
     if (hue > 41){
       
      hue = 39; 
     }
   }
}

class Grass extends Particle{  
  Grass(PVector _pos){
     super(new PVector(_pos.x,_pos.y),
           new PVector(random(-1,1),random(-1,1)),
           new PVector(0,0),
           0,0,
           0,
                            random(3,5),
                            random(86,146),random(225,255),random(0,255),
                            1.5); 
   }
   
   void design(){
        /*triangle( 0,-size,
               size,0,
               0,size
             );*/
     stroke(1,lifespan);
     strokeWeight(2);
     noStroke();
     fill(hue,sat,bri,lifespan);
     star(0,0,size*2,size-size/4,2);        
  }
}