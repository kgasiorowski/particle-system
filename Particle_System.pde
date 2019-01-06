import controlP5.*;

final color EMPTY_COLOR = color(0);
final color PRT_COLOR = color(255, 234, 130);
final boolean testrect = false;
final int brushsize = 2;

final int controlwidth = 200;
final int renderwidth = 720;

ControlP5 cp5;
Slider drift_slider, stick_slider, brush_slider;
CheckBox rect_checkbox;

ArrayList<Particle> particles;

void setup(){

    cp5 = new ControlP5(this);
    drift_slider = cp5.addSlider("Drift Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, 10)
        .setValue(0.1);
    
    stick_slider = cp5.addSlider("Stick Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, 40)
        .setValue(.75);
    
    brush_slider = cp5.addSlider("Brush Size")
        .setRange(1, 3)
        .setNumberOfTickMarks(3)
        .setPosition(renderwidth+10, 70)
        .setValue(1);
    
    rect_checkbox = cp5.addCheckBox("Test rectangle")
        .setPosition(renderwidth+10, 100)
        .setSize(10, 10)
        .addItem("Draw rectangle", 0);
    
    particles = new ArrayList();
    background(EMPTY_COLOR);
    stroke(PRT_COLOR);
    //fullScreen();
    size(920,600);
    noSmooth();
  
}

void draw(){
  
    loadPixels();
    background(EMPTY_COLOR);
      
    if(rect_checkbox.getItem(0).getState()){
      
        color rectcolor = color(128,128,128);
        stroke(rectcolor);
        fill(rectcolor);
        rect(renderwidth*.1, height*.95, renderwidth*.8, 10);
    
    }
    
    color settingsColor = color (193, 217, 255);
    noStroke(); 
    fill(settingsColor);
    rect(renderwidth, 0, controlwidth, height);
      
    if(mousePressed){
    
        int mx = mouseX;
        int my = mouseY;
        
        if(mx < width-controlwidth)
            paintbrush(mx, my);
      
    }
      
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
