class ParticleSystem{
  
  ArrayList<Particle> particles;
  
  
  //System
  float lifespanspeed;
  
  //Fuerzas :
  PVector pos;
  PVector speed;
  PVector accel;
  float stm;
  
  //Geometry :
  float amp;
  float ampspeed;
  float angle;
  float Aspeed;
  float Aaccel;
  float hue;
 
  
  //Particle
  float Plifespanspeed;
  float Psize;
  
  
  ParticleSystem(PVector _pos){
   
   
   pos = _pos;
   
   Plifespanspeed = 0.5;
   lifespanspeed = 0;
  
   particles = new ArrayList<Particle>(); 
   
   Psize = 2;
   
   speed = new PVector(0.001,0.001);
   //accel = new PVector(random(0.01,-0.01),random(0.01,-0.01));
   accel = new PVector(0,0);
   stm = 5;
   
   
   Aaccel = 0;
   Aspeed = 0.0001;
   amp =0;
   ampspeed=0;
  
   hue = random(255);
  }
  
  
  void run(){
    
    //changeSize();
    
    update();
   // changeHue(0.1);  
    
    if(!isDead()){
    addParticle();
    }
    
    Psize-=lifespanspeed;
    
    for (int i =particles.size()-1; i>=0 ; i--){
    Particle p = particles.get(i);  
      p.run();
      if (p.isDead()){
       particles.remove(i); 
      }
    }
    
    /*Bueno acá debería andar el Iterator, pero por alguna razón que desconozco totalmente no funciona. 
    así que vamos a dejar la opción anterior. Igual acá esta el codigo tal como esta en el tutorial, 
    que quede por las dudas */
    /*
    Iterator<Particle> it =
        particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }*/
  }
  void changeHue(float Shue){
    hue+=Shue;
    if(hue > 255){
     hue=0; 
    }
  }
  
  void update(){
    
    checkEdges();
    
    //atractTomouse();
    //forces();
     angular();
  }
  void forces(){
    speed.add(accel);
    speed.limit(8);
    pos.add(speed);
  }
  
  void angular(){
    
    amp+=ampspeed;
    Aspeed+=Aaccel; 
    angle+=Aspeed;
       
    pos.add(amp * sin(angle * 100 ),0);
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
  
  void changeSize(){
    if (mousePressed){
     Psize+=0.5; 
    }
    else if (Psize > 0){
     Psize-=0.5; 
    }
  }
  
  
  void addParticle(){
  
     if (Ptype == 0){
        particles.add(new Particle(new PVector(pos.x,pos.y)));   
     }
     if (Ptype == 1) {  
        particles.add(new Fire(new PVector(pos.x,pos.y)));       
     }
     if (Ptype == 2) {
      particles.add(new Grass(new PVector(pos.x,pos.y)));    
     }
 
     if (Ptype == 3) {
       particles.add(new Particle( pos,
          new PVector (0,0),
          new PVector( random(-10,10),random(-10,10))  ,
           5 , 4,
           10,
           30,
           130, 220, random(100,255),
            5 ));
     }
   }
   void setPos(PVector _pos){
     
     pos = _pos;
   }
   void checkEdges(){
        if (pos.x > width){
            pos.x = width;
            speed.x *= -1;
        }
        
          if (pos.x < 0){
            pos.x = 0;  
            speed.x *= -1;
        }
        
          if (pos.y > height){
            pos.y = height;
            speed.y *= -1;
        }
         if (pos.y < 0){
            pos.y = 0; 
            speed.y *= -1;
        }
   }
 
  boolean isDead(){
    
    if (Psize < 0){
    return true;
    }
    else{
      return false;
    }
  }
  
}