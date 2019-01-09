ControlP5 cp5;
Slider brush_slider;
Button reset;
ScrollableList options;
Toggle eraser;

void setupGUI(){
    
    cp5 = new ControlP5(this);
    
    int baseoffset = 10;
    
    reset = cp5.addButton("Reset")
        .setPosition(renderwidth+10, baseoffset);
    
    brush_slider = cp5.addSlider("Brush Size")
        .setRange(0, 3)
        .setNumberOfTickMarks(4)
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setValue(2);

    List particleOptions = new ArrayList();
    for(PARTICLE_TYPE p : PARTICLE_TYPE.values()){
    
        particleOptions.add(p.getProps().name);
    
    }
    
    options = cp5.addScrollableList("Options")
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setItems(particleOptions)
        .setType(ControlP5.LIST);

    cp5.addFrameRate()
        .setPosition(10,10);

}

void Reset(){
    
    // More efficient than entirely clearing the array
    for(Particle p : particles)
        particleMap[p.x][p.y] = null;
    
    particles.clear();

}

void Options(int n){

    current_type = PARTICLE_TYPE.values()[n];
    
}

void drawGUI(){

    color settingsColor = color (193, 217, 255);
    noStroke(); 
    fill(settingsColor);
    rect(renderwidth, 0, controlwidth, height);

}
