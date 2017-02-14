class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector pos;
  float radio;

  ParticleSystem(PVector _pos) {
    pos = _pos;
    radio = 20;
  }
  
  ParticleSystem(PVector _pos,float _radio) {
    pos = _pos;
    radio = _radio;
  }

  
  void display(PVector _angle_speed) {
     
    AgregarParticula(_angle_speed);
    for (int i = particles.size()-1; i >= 0; i--) {

      Particle p = (Particle) particles.get(i);
      p.run();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  void AgregarParticula(PVector _angle_speed){
     
    PVector Posplusradio = PVector.add(pos,spawnRadio(radio));                 
    particles.add(new P_Pepe(Posplusradio,_angle_speed,random(5,20)));
  }
  
  
 void display() {
   
    particles.add(new Particle( pos));
                                
    for (int i = particles.size()-1; i >= 0; i--) {

      Particle p = (Particle) particles.get(i);
      p.run();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
   void display(float _spawnradio) {
   
    PVector Posplusradio = PVector.add(pos,spawnRadio(_spawnradio));          
    particles.add(new Particle( Posplusradio));
                                
    for (int i = particles.size()-1; i >= 0; i--) {

      Particle p = (Particle) particles.get(i);
      p.run();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
 
  PVector spawnRadio(float _radio){
    float amp = random(0, _radio);    
    float rdmx = amp * sin(random(90));
    float rdmy = amp * cos(random(90));
    PVector radio = new PVector(rdmx,rdmy);
    return radio; 
  }
  
  void setPos(float _x,float _y){
    
    pos = new PVector(_x,_y);
  }



}