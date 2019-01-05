class Particle{
  
  PVector pos;
  int prt_color;
  
  Particle(int x, int y){
    pos = new PVector(x,y);
  }

  Particle(int x, int y, int _color){
    this(x, y);
    prt_color = _color;
  }

  int x(){
    return int(pos.x);
  }

  int y(){
    return int(pos.y);
  }

  int colorBelow(){
    return get(int(pos.x), int(pos.y+1))&0xFFFFFF;
  }

  int colorLeftBottom(){
    return get(int(pos.x-1), int(pos.y+1))&0xFFFFFF;
  }

  int colorRightBottom(){
    return get(int(pos.x+1), int(pos.y+1))&0xFFFFFF;
  }

  int colorRight(){
    return get(int(pos.x+1), int(pos.y))&0xFFFFFF;
  }

  int colorLeft(){
    return get(int(pos.x-1), int(pos.y))&0xFFFFFF;
  }

  int colorTop(){
    return get(int(pos.x), int(pos.y-1))&0xFFFFFF;
  }

  int colorTopRight(){
    return get(int(pos.x+1), int(pos.y-1))&0xFFFFFF;
  }

  int colorTopLeft(){
    return get(int(pos.x-1), int(pos.y-1))&0xFFFFFF;
  }

  void step(){
    
    // If the color below this particle is blocking, dont do anything
    //int colorBelow = colorBelow();
    
    //println("x:"+pos.x, "y:"+pos.y, "Color below: " + hex(colorBelow));
    
    if(colorBelow() == PRT_COLOR && (pos.y != height-1)){
      return;
    }
    
    // Move one down if nothing is blocking
    pos.y += grav_const;
  
    // Do some horizontal jiggling
    int drift = 0;
    if(random(0,1) <= drift_factor){
    
      drift = int(random(-2,2));
      
      // Prevent particles from getting deleted from jiggling to the left or right
      if(drift == -1 && colorLeftBottom() == PRT_COLOR){
      
        // Drift is to the left
        drift = 0;
        
      }else if(drift == 1 && colorRightBottom() == PRT_COLOR){
      
        // Drift is to the right
        drift = 0;
      
      }
    
    }
    pos.x += drift;
  
  }

}

final int BCK_COLOR = 0xEEEEEE;
final int PRT_COLOR = 0x000000;
final int grav_const = 1;
final float drift_factor = 0.1;
ArrayList<Particle> particles;

void setup(){

  particles = new ArrayList();
  background(BCK_COLOR);
  stroke(PRT_COLOR);
  //fullScreen();
  size(300,300);
  noSmooth();
  
}

void draw(){
  
  loadPixels();
  background(BCK_COLOR);
  stroke(PRT_COLOR);
  fill(0x0);
  
  rect(0, height*.95, width-1, height-1);
  
  if(mousePressed){
  
    createNewParticle(mouseX, mouseY);
  
  }
  
  deleteDeadParticles();
  
  for(Particle p : particles){
    p.step();
    point(p.x(), p.y());
  }
  
}

void point(PVector pos){
  
  point(pos.x, pos.y);

}

void createNewParticle(int x, int y){

  particles.add(new Particle(x, y));
  println(particles.size());

}

void mousePressed(){
  //createNewParticle(mouseX, mouseY);
}

void mouseDragged(){
  //createNewParticle(mouseX, mouseY);
}

void keyPressed(){
  redraw();
}

void deleteDeadParticles(){
  
  // Iterate backwards to avoid errors
  for(int i = particles.size()-1; i >= 0; i--){
  
    if(particles.get(i).y() >= height || particles.get(i).x() >= width){
      
      particles.remove(i);
      println(particles.size());
      
    }
    
  }

}
