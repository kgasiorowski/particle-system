ControlP5 cp5;
Slider drift_slider, stick_slider, brush_slider, flow_slider;
Button reset;
CheckBox rect_checkbox;
ColorWheel particle_cp;
ScrollableList options;

void setupGUI(){
    
    cp5 = new ControlP5(this);
    
    int baseoffset = 10;
    
    reset = cp5.addButton("Reset")
        .setPosition(renderwidth+10, baseoffset);
    
    drift_slider = cp5.addSlider("Drift Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setValue(0.1);
    
    stick_slider = cp5.addSlider("Stick Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setValue(.75);
    
    flow_slider = cp5.addSlider("Flow Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setValue(0);
    
    brush_slider = cp5.addSlider("Brush Size")
        .setRange(0, 3)
        .setNumberOfTickMarks(4)
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setValue(2);

    particle_cp = cp5.addColorWheel("Particle Color")
        .setPosition(renderwidth+10, (baseoffset += 30))
        .setRGB(0xFFEA82)
        .setAlpha(0xFF);

    List particleOptions = new ArrayList();
    for(PARTICLE_TYPE p : PARTICLE_TYPE.values()){
    
        particleOptions.add(p.getName());
    
    }
    
    options = cp5.addScrollableList("Options")
        .setPosition(renderwidth+10, (baseoffset += 220))
        .setItems(particleOptions)
        .setType(ControlP5.DROPDOWN);

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

    switch(n){
    
        case 0:
            type = PARTICLE_TYPE.DYNAMIC;
        break;
        case 1:
            type = PARTICLE_TYPE.STATIC;
        break;
        case 2:
            type = PARTICLE_TYPE.ERASER;
        break;
    
    }

}

void drawGUI(){

    color settingsColor = color (193, 217, 255);
    noStroke(); 
    fill(settingsColor);
    rect(renderwidth, 0, controlwidth, height);

}
