ControlP5 cp5;
Slider drift_slider, stick_slider, brush_slider, flow_slider;
Button reset;
CheckBox rect_checkbox;
ColorWheel particle_cp;

void setupGUI(){
    
    cp5 = new ControlP5(this);
    
    reset = cp5.addButton("Reset")
        .setPosition(renderwidth+10, 10);
    
    drift_slider = cp5.addSlider("Drift Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, 40)
        .setValue(0.1);
    
    stick_slider = cp5.addSlider("Stick Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, 70)
        .setValue(.75);
    
    flow_slider = cp5.addSlider("Flow Factor")
        .setRange(0,1)
        .setPosition(renderwidth+10, 100)
        .setValue(0);
    
    brush_slider = cp5.addSlider("Brush Size")
        .setRange(0, 3)
        .setNumberOfTickMarks(4)
        .setPosition(renderwidth+10, 130)
        .setValue(3);
    
    rect_checkbox = cp5.addCheckBox("")
        .setPosition(renderwidth+10, 160)
        .setSize(10, 10)
        .addItem("Static Particles", 1);

    particle_cp = cp5.addColorWheel("Particle Color")
        .setPosition(renderwidth+10, 190)
        .setRGB(0x00FFEA82)
        .setAlpha(0xFF);

    

    cp5.addFrameRate()
        .setPosition(10,10);

}

void Reset(){
    
    particles.clear();

}

void drawControls(){

    color settingsColor = color (193, 217, 255);
    noStroke(); 
    fill(settingsColor);
    rect(renderwidth, 0, controlwidth, height);

}
