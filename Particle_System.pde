import controlP5.*;
import java.util.List;
import java.util.Arrays;

color BACKGROUND_COLOR = color(0);

final int controlwidth = 220;
final int renderwidth = 720;

ArrayList<Particle> particles;
Particle particleMap[][];

void setup(){

    // Set up our GUI
    setupGUI();
    
    // Init our data structures
    particles = new ArrayList();
    particleMap = new Particle[width-controlwidth][height];
    
    // Init our basic work area
    background(BACKGROUND_COLOR);
    size(940,600);
    noSmooth();
      
}

void draw(){
  
    loadPixels();
    
    background(BACKGROUND_COLOR);
    drawGUI();
    
    if(mousePressed){
    
        //if(default_type == PARTICLE_TYPE.ERASER){
        
        //    eraseBrush();
            
        //}else{
            
            if(mouseX < width-controlwidth)
            {
                paintbrush(mouseX, mouseY);
                paintbrush(pmouseX, pmouseY);
            }
      
        //}
        
    }
      
    deleteDeadParticles();
    
    for(Particle p : particles){
        if(!p.isStatic)
             p.step();
        p.draw();
    }
      
}

void createNewParticle(int x, int y){
    
    if(validateCoords(x, y))
        return;
    
    for(Particle p : particles)
        if(p.x == x && p.y == y)
            return;
      
    Particle newParticle = new Particle(x, y, current_type.getProps());
    
    particleMap[x][y] = newParticle;
    particles.add(newParticle);
    
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
        
        if(p.dead){
          
            particleMap[p.x][p.y] = null;
            particles.remove(i);
          
        }
        
    }

}

void eraseBrush(){

    int x = mouseX, y = mouseY;
    int px = pmouseX, py = pmouseY;
    
    if(validateCoords(x, y) && validateCoords(px, py))
        return;
        
    Particle p;
        
    p = particleMap[x][y];
    if(p != null)
        p.dead = true;
    
    p = particleMap[px][py];
    if(p != null)
        p.dead = true;

}

boolean validateCoords(int x, int y){

    return x < 0 || y < 0 || x > particleMap.length-1 || y > particleMap[0].length-1;
    
}
