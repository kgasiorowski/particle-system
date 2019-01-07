final int grav_const = 1;

class Particle{
  
    PVector pos;
    final int prt_color;
    boolean isStatic;

    Particle(int x, int y, int _color){
        pos = new PVector(x,y);
        prt_color = _color;
        isStatic = false;
    }

    Particle(int x, int y, int _color, boolean _isStatic){
    
        pos = new PVector(x, y);
        prt_color = _color;
        isStatic = _isStatic;
        
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
        
        // Particle is blocked from moving lower.
        if(colorBottom() != EMPTY_COLOR && (pos.y < height-1)){
            
            //Particles should "cascade" if there's free space to the left or right
            if(colorBottomLeft() == EMPTY_COLOR || colorBottomRight() == EMPTY_COLOR){
                
                // Since we are "cascading" the particle will always go down one (hence dy is always 1)
                int dx = 0, dy = 1;
                
                // Figure out if we're shifting the the left or right
                if(colorBottomLeft() == EMPTY_COLOR && colorBottomRight() != EMPTY_COLOR)
                    dx = -1;
                else if(colorBottomRight() == EMPTY_COLOR && colorBottomLeft() != EMPTY_COLOR)
                    dx = 1;
                else
                    dx = int(random(0,2)) == 0 ? -1 : 1;
            
                // Roll a random number to control the frequency of cascades
                if(random(0,1) > stick_slider.getValue()){
                
                    pos.x += dx;
                    pos.y += dy;
                
                }
            
            }else if(colorLeft() == EMPTY_COLOR || colorRight() == EMPTY_COLOR){
            
                int dx = 0;
                
                if(colorLeft() == EMPTY_COLOR && colorRight() != EMPTY_COLOR)
                    dx = -1;
                else if(colorRight() == EMPTY_COLOR && colorLeft() != EMPTY_COLOR)
                    dx = 1;
                else{
                    
                    dx = int(random(0,2)) == 0? -1 : 1;
                
                }
                 
                if(random(0,1) < flow_slider.getValue())
                    pos.x += dx;
            
            }
          
        }else{
            
            // Particle is not blocked
            // Move one down
            pos.y += grav_const;
            
            // Do some horizontal jiggling
            if(random(0,1) <= drift_slider.getValue()){
              
                int drift = 0;
                
                if(colorLeft() == EMPTY_COLOR && colorRight() != EMPTY_COLOR)
                    drift = -1;
                else if(colorRight() == EMPTY_COLOR && colorLeft() != EMPTY_COLOR)
                    drift = 1;
                else if(colorRight() == EMPTY_COLOR && colorLeft() == EMPTY_COLOR)
                    drift = int(random(0,2)) == 0? -1 : 1;
                
                pos.x += drift;
                  
            }
            
        }
            
    }

}
