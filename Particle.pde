final int grav_const = 1;

class Particle{
  
    int x, y;
    final int prt_color;
    boolean isStatic;
    boolean dead;

    Particle(int _x, int _y, int _color){
        x = _x;
        y = _y;
        prt_color = _color;
        isStatic = false;
        dead = false;
    }

    Particle(int _x, int _y, int _color, boolean _isStatic){
        x = _x;
        y = _y;
        prt_color = _color;
        isStatic = _isStatic;
        dead = false;
    }

    @Override
    String toString(){
    
        return "Posx:"+ x + "Posy:" + y + " Color:" + hex(prt_color);
    
    }

    Particle getBottom(){
        return particleMap[x][y+1];
    }

    Particle getBottomLeft(){
        return particleMap[x-1][y+1];
    }

    Particle getBottomRight(){
        return particleMap[x+1][y+1];
    }

    Particle getRight(){
        return particleMap[x+1][y];
    }

    Particle getLeft(){
        return particleMap[x-1][y];    
    }

    Particle getTop(){
        return particleMap[x][y-1];    
    }

    Particle getTopRight(){
        return particleMap[x+1][y-1];
    }

    Particle getTopLeft(){
        return particleMap[x-1][y-1];
    }

    void draw(){
      
        stroke(prt_color);
        point(x, y);
      
    }

    void step(){
        
        if(y > height-2 || x >= width-controlwidth-1 || x < 1 || y < 1){
            
            dead = true;
            return;
            
        }
        
        int oldx, oldy;
        
        oldx = x;
        oldy = y;
          
        if(getBottom() != null && (y < height-1)){
            
            //Particles should "cascade" if there's free space to the left or right
            if(getBottomRight() == null || getBottomLeft() == null){
                
                // Since we are "cascading" the particle will always go down one (hence dy is always 1)
                int dx = 0, dy = 1;
                
                // Figure out if we're shifting the the left or right
                if(getBottomLeft() == null && getBottomRight() != null)
                    dx = -1;
                else if(getBottomRight() == null && getBottomLeft() != null)
                    dx = 1;
                else
                    dx = int(random(0,2)) == 0 ? -1 : 1;
            
                // Roll a random number to control the frequency of cascades
                if(random(0,1) > stick_slider.getValue()){
                
                    x += dx;
                    y += dy;
                
                }
            
            }else if(getLeft() == null || getRight() == null){
            
                int dx = 0;
                
                if(getLeft() == null && getRight() != null)
                    dx = -1;
                else if(getRight() == null && getLeft() != null)
                    dx = 1;
                else{
                    
                    dx = int(random(0,2)) == 0? -1 : 1;
                
                }
                 
                if(random(0,1) < flow_slider.getValue())
                    x += dx;
            
            }
          
        }else{
            
            // Particle is not blocked
            // Move one down
            y += grav_const;
            
            // Do some horizontal jiggling
            if(random(0,1) <= drift_slider.getValue()){
              
                int drift = 0;
                
                if(getLeft() == null && getRight() != null)
                    drift = -1;
                else if(getRight() == null && getLeft() != null)
                    drift = 1;
                else if(getRight() == null && getLeft() == null)
                    drift = int(random(0,2)) == 0? -1 : 1;
                
                x += drift;
                  
            }
            
        }
        
        // Since the particle has moved in some way, erase that old matrix spot and set the new one
        particleMap[oldx][oldy] = null;
        particleMap[x][y] = this;
            
    }

}
