import controlP5.*;
import java.util.List;
import java.util.Arrays;

color BACKGROUND_COLOR = color(0);

final int controlwidth = 220;
int renderwidth;

ArrayList<Particle> particles;
ArrayList<Particle> delayedAdd;
Particle particleMap[][];

void setup(){
    
    // Init our basic work area
    background(BACKGROUND_COLOR);
    //size(940,600);
    //size(1080, 600);
    
    fullScreen();
    noSmooth();

    renderwidth = width-controlwidth;
      
    // Set up our GUI
    setupGUI();
      
    // Init our data structures
    particles = new ArrayList();
    delayedAdd = new ArrayList();
    particleMap = new Particle[width-controlwidth][height];
      
}

void draw(){
  
    loadPixels();
    
    background(BACKGROUND_COLOR);
    drawGUI();
    
    if(mousePressed){
    
        paintbrush(mouseX, mouseY);
        paintbrush(pmouseX, pmouseY);
        
    }
      
    deleteDeadParticles();
    
    PARTICLE_TYPE saved = current_type;
    for(Particle p : delayedAdd){
        
        current_type = p.type;
        createNewParticle(p.x, p.y);
        
    }
    delayedAdd.clear();
    current_type = saved;
    
    for(Particle p : particles){
        p.step();
        p.draw();
    }
      
}

void createNewParticle(int x, int y){
    
    if(validateCoords(x, y))
        return;
    
    particles.remove(particleMap[x][y]);
    particleMap[x][y] = null;
    
    Particle newParticle = new Particle(x, y, current_type);
    
    particleMap[x][y] = newParticle;
    particles.add(newParticle);
    
}

void paintbrush(int x, int y){
  
    int r = int(brush_slider.getValue());
    
    for(int i = x-r; i < x+r+1; i++)
        for(int j = y-r; j < y+r+1; j++)
            if(eraser.getState())
                markAsDead(i, j);
            else
                createNewParticle(i, j);
            
    updateParticleSize();
    
    
}

void deleteDeadParticles(){
  
    // Iterate backwards to avoid errors
    for(int i = particles.size()-1; i >= 0; i--){
      
        Particle p = particles.get(i);
        
        if(p.dead){
          
            particleMap[p.x][p.y] = null;
            particles.remove(i);
          
        }
        
    }

    updateParticleSize();

}

void markAsDead(int x, int y){
    
    if(validateCoords(x, y))
        return;
        
    Particle p = particleMap[x][y];
    if(p != null)
        p.dead = true;
        
}

boolean validateCoords(int x, int y){

    return x < 0 || y < 0 || x > particleMap.length-1 || y > particleMap[0].length-1;
    
}
