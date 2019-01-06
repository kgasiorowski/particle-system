final int grav_const = 1;

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

    int colorBottom(){
        return get(int(pos.x), int(pos.y+1));
    }

    int colorBottomLeft(){
        return get(int(pos.x-1), int(pos.y+1));
    }

    int colorBottomRight(){
        return get(int(pos.x+1), int(pos.y+1));
    }

    int colorRight(){
        return get(int(pos.x+1), int(pos.y));
    }

    int colorLeft(){
        return get(int(pos.x-1), int(pos.y));
    }

    int colorTop(){
        return get(int(pos.x), int(pos.y-1));
    }

    int colorTopRight(){
        return get(int(pos.x+1), int(pos.y-1));
    }

    int colorTopLeft(){
        return get(int(pos.x-1), int(pos.y-1));
    }

    void draw(){
      
        stroke(prt_color);
        point(pos.x, pos.y);
      
    }

    void step(){
    
        if(colorBottom() != EMPTY_COLOR && (pos.y != height-1)){
            // Particle is blocked from moving lower.
            if(random(0,1) > stick_slider.getValue()){
              
                //Particles should "cascade" if there's free space to the left or right
                if(colorBottomLeft() == EMPTY_COLOR){
                
                    pos.x += -1;
                    pos.y += 1;
                
                }else if(colorBottomRight() == EMPTY_COLOR){
                
                    pos.x += 1;
                    pos.y += 1;
                
                }
            
            }
          
        }else{
            
            // Particle is not blocked
            // Move one down
            pos.y += grav_const;
            
            // Do some horizontal jiggling
            int drift = 0;
            if(random(0,1) <= drift_slider.getValue()){
              
                drift = int(random(-2,2));
                
                // Prevent particles from colliding to the left or right
                if((drift == -1 && colorBottomLeft() != EMPTY_COLOR) || (drift == 1 && colorBottomRight() != EMPTY_COLOR))
                    drift = 0;
                  
            }
                  
            pos.x += drift;
            
        }
            
    }

}
