final int grav_const = 1;

class Particle{
  
    int x, y;
    int prt_color;
    boolean isStatic;
    boolean dead;
    float stick_factor;
    float float_factor;
    float drift_factor;

    Particle(int _x, int _y, ParticleProperties p){
        x = _x;
        y = _y;
        isStatic = p.isStatic;
        prt_color = p.prt_color;
        stick_factor = p.stick_factor;
        float_factor = p.float_factor;
        drift_factor = p.drift_factor;
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
                int dx = 0, dy = grav_const;
                
                // Figure out if we're shifting the the left or right
                if(getBottomLeft() == null && getBottomRight() != null)
                    dx = -1;
                else if(getBottomRight() == null && getBottomLeft() != null)
                    dx = 1;
                else
                    dx = int(random(0,2)) == 0 ? -1 : 1;
            
                // Roll a random number to control the frequency of cascades
                if(random(0,1) > stick_factor){
                
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
                 
                if(random(0,1) < float_factor)
                    x += dx;
            
            }
          
        }else{
            
            // Particle is not blocked
            // Move one down
            y += grav_const;
            
            // Do some horizontal jiggling
            if(random(0,1) <= drift_factor){
              
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
