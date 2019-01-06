final color EMPTY_COLOR = color(0);
final color PRT_COLOR = color(255, 234, 130);
ArrayList<Particle> particles;

final boolean rect = true;

void setup(){

  particles = new ArrayList();
  background(EMPTY_COLOR);
  stroke(PRT_COLOR);
  //fullScreen();
  size(720,600);
  noSmooth();
  
}

void draw(){
  
  loadPixels();
  background(EMPTY_COLOR);
  
  if(rect){
  
    color rectcolor = color(128,128,128);
    stroke(rectcolor);
    fill(rectcolor);
    rect(0, height*.70, width-1, height-1);
    
  }
  
  if(mousePressed)
    paintbrush(mouseX, mouseY, 2);
  
  deleteDeadParticles();
  
  for(Particle p : particles){
    p.step();
    p.draw();
  }
  
}

void createNewParticle(int x, int y){

  for(Particle p : particles)
    if(p.x() == x && p.y() == y)
      return;
  
  particles.add(new Particle(x, y, PRT_COLOR));
  println(particles.size());

}

void paintbrush(int x, int y, int r){
  
  for(int i = x-r; i < x+r+1; i++)
    for(int j = y-r; j < y+r+1; j++)
      createNewParticle(i, j);
    
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

void keyPressed(){
  //stick_factor = abs(stick_factor - 1);
}
