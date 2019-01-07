import controlP5.*;

final color EMPTY_COLOR = color(0);
final color PRT_COLOR = color(255, 234, 130);
final int brushsize = 2;

final int controlwidth = 220;
final int renderwidth = 720;

ArrayList<Particle> particles;

void setup(){

    setupGUI();
    particles = new ArrayList();
    background(EMPTY_COLOR);
    stroke(PRT_COLOR);
    size(940,600);
    noSmooth();
  
}

void draw(){
  
    loadPixels();
    
    background(EMPTY_COLOR);
    drawControls();
    
    if(mousePressed){
    
        int mx = mouseX;
        int my = mouseY;
        
        if(mx < width-controlwidth)
            paintbrush(mx, my);
      
    }
      
    deleteDeadParticles();
    
    for(Particle p : particles){
        if(!p.isStatic)
             p.step();
        p.draw();
    }
      
    
      
}

void createNewParticle(int x, int y){

    for(Particle p : particles)
        if(p.x() == x && p.y() == y)
            return;
      
    particles.add(new Particle(x, y, particle_cp.getRGB(), rect_checkbox.getState("Static Particles")));
    println(particles.size());

}

void paintbrush(int x, int y){
  
    int r = int(brush_slider.getValue());
    
    for(int i = x-r; i < x+r+1; i++)
        for(int j = y-r; j < y+r+1; j++)
            createNewParticle(i, j);
    
}

void deleteDeadParticles(){
  
    // Iterate backwards to avoid errors
    for(int i = particles.size()-1; i >= 0; i--){
      
        Particle p = particles.get(i);
        
        if(p.y() >= height || p.x() >= width-controlwidth || p.x() < 1){
          
            particles.remove(i);
            println(particles.size());
          
        }
        
    }

}
