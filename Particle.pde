final int grav_const = 1;

class Particle{
  
    int x, y;
    //int px, py;
    int prt_color;
    boolean isStatic;
    boolean dead;
    float stick_factor;
    float float_factor;
    float drift_factor;
    int density;
    int lifetime;
    float flammability;
    PARTICLE_TYPE type;
    String name;
    float corrosive;
    PARTICLE_TYPE generator;
    
    Particle(int _x, int _y, PARTICLE_TYPE _type){
        x = _x;
        y = _y;
        
        // Unpack the properties for this type of particle
        ParticleProperties p = _type.getProps();
        isStatic = p.isStatic;
        prt_color = p.prt_color;
        stick_factor = p.stick_factor;
        float_factor = p.float_factor;
        drift_factor = p.drift_factor;
        lifetime = p.lifetime;
        flammability = p.flammability;
        type = _type;
        name = p.name;
        corrosive = p.corrosive;
        generator = p.generator;
        
        if(isStatic){
            density = Integer.MAX_VALUE;
        }else{
            density = p.density;
        }
        
        dead = false;
        
    }

    void transform(PARTICLE_TYPE newType){
    
        ParticleProperties p = newType.getProps();
    
        isStatic = p.isStatic;
        prt_color = p.prt_color;
        stick_factor = p.stick_factor;
        float_factor = p.float_factor;
        drift_factor = p.drift_factor;
        type = newType;
        flammability = p.flammability;
        lifetime = p.lifetime;
        name = p.name;
        corrosive = p.corrosive;
        
        if(isStatic){
            density = Integer.MAX_VALUE;
        }else{
            density = p.density;
        }
    
    }

    @Override
    String toString(){
        return "Posx:"+ x + "Posy:" + y + " Color:" + hex(prt_color);
    }

    List<Particle> getNeighbors(){
    
        ArrayList<Particle> neighbors = new ArrayList();
        
        neighbors.add(getTopLeft());
        neighbors.add(getTop());
        neighbors.add(getTopRight());
        neighbors.add(getLeft());
        neighbors.add(getRight());
        neighbors.add(getBottomLeft());
        neighbors.add(getBottom());
        neighbors.add(getBottomRight());
        
        return neighbors;
    
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

    void randomGen(PARTICLE_TYPE type){
    
        if(random(0,1) < 0.1 && (getTop() == null || getBottom() == null || getRight() == null || getLeft() == null)){
                
                boolean spawned = false;
                while(!spawned){
                
                    float roll = random(1);
                    
                    if(getTop() == null && roll <= .25){
                    
                        delayedAdd.add(new Particle(x, y-1, type));
                        spawned = true;
                    
                    }else if(getRight() == null && roll > .25 && roll <= .5){
                    
                        delayedAdd.add(new Particle(x+1, y, type));
                        spawned = true;
                    
                    }else if(getLeft() == null && roll > .5 && roll <= .75){
                    
                        delayedAdd.add(new Particle(x-1, y, type));
                        spawned = true;
                    
                    }else if(getBottom() == null && roll > .75){
                    
                        delayedAdd.add(new Particle(x, y+1, type));
                        spawned = true;
                    
                    }else{
                    
                        spawned = true;
                    
                    }
                
                }
            
            }
        
    }

    void draw(){
      
        stroke(prt_color);
        point(x, y);
      
    }

    void step(){
        
        if(y > height-2 || x >= width-controlwidth-1 || x < 1 || y < 1 || prt_color == BACKGROUND_COLOR || dead){
            
            dead = true;
            return;
            
        }
        
        // Static logic goes here
        if(this.type == PARTICLE_TYPE.PLANT || this.type == PARTICLE_TYPE.WOOD){
            
            List<Particle> neighbors = getNeighbors();
            
            for(Particle p : neighbors)
                if(p != null && p.type == PARTICLE_TYPE.WATER)
                    p.transform(PARTICLE_TYPE.PLANT);
                
        }else if(this.type == PARTICLE_TYPE.FIRE || this.type == PARTICLE_TYPE.TORCH){ //<>//
        
            if(this.type == PARTICLE_TYPE.FIRE && lifetime == 0)
                dead = true;
            
            List<Particle> neighbors = getNeighbors();
            
            for(Particle p : neighbors){
                
                if(p != null && random(0,1) < p.flammability){
                    p.transform(PARTICLE_TYPE.FIRE);
                }
            
            }
            
            if(this.type == PARTICLE_TYPE.FIRE)
              lifetime--;
              
        }else if(this.generator != null){
        
            randomGen(generator);
        
        }
        
        if(isStatic)
            return;
        
        if(this.type == PARTICLE_TYPE.CEMENT){
            
            if(random(0,1) < 0.33)
                lifetime--;
        
            if(lifetime == 0)
                transform(PARTICLE_TYPE.CONCRETE);
        
        }else if(this.type == PARTICLE_TYPE.ACID){
        
            // This needs to be re-written
            if(getLeft() != null && getLeft().corrosive > 0 && (getRight() == null || getRight().corrosive <= 0)){
            
                if(random(0,1) < getLeft().corrosive){
                    
                    this.dead = true;
                    particleMap[x-1][y].dead = true;
                    return;
                
                }
                
            }else if(getRight() != null && getRight().corrosive > 0 && (getLeft() == null || getLeft().corrosive <= 0)){
                
                if(random(0,1) < getRight().corrosive){
                    
                    this.dead = true;
                    particleMap[x+1][y].dead = true;
                    return;
                    
                }
            
            }else if(getRight() != null && getRight().corrosive > 0 && getLeft() != null && getLeft().corrosive > 0){
            
                int dx = int(random(0,2)) == 0 ? -1 : 1;
                this.dead = true;
                particleMap[x+dx][y].dead = true;
                return;
            
            }
        
        }
        
        int oldx = x, oldy = y;
        
        Particle b = getBottom();
        
        if(b != null && (y < height-1)){
            
            Particle br = getBottomRight(), bl = getBottomLeft(), r = getRight(), l = getLeft();
            
            boolean bottomRightFree = (br == null || br.density < this.density);
            boolean bottomLeftFree = (bl == null || bl.density < this.density);
            boolean rightFree = (r == null || r.density < this.density);
            boolean leftFree = (l == null || l.density < this.density);
            
            if((this.type == PARTICLE_TYPE.WATER && b.type == PARTICLE_TYPE.SALT) || 
                (this.type == PARTICLE_TYPE.SALT && b.type == PARTICLE_TYPE.WATER))
            {
            
                particleMap[x][y+1].transform(PARTICLE_TYPE.SALTWATER);
                //particleMap[x][y].dead = true;
                this.dead = true;
                return;
            
            }else if(this.type == PARTICLE_TYPE.ACID && random(0,1) < getBottom().corrosive){
                
                this.dead = true;
                particleMap[x][y+1].dead = true;
                return;
            
            }
            
            if(b.density < this.density){
            
                y += 1;
            
            }else if(bottomRightFree && rightFree || bottomLeftFree && leftFree){
                
                //Particles should "cascade" if there's free space to the left or right
                // Since we are "cascading" the particle will always go down one (hence dy is always 1)
                int dx = 0, dy = grav_const;
                
                // Figure out if we're shifting the the left or right
                if(bottomLeftFree && !bottomRightFree)
                    dx = -1;
                else if(bottomRightFree && !bottomLeftFree)
                    dx = 1;
                else
                    dx = int(random(0,2)) == 0 ? -1 : 1;
            
                // Roll a random number to control the frequency of cascades
                if(random(0,1) > stick_factor){
                
                    x += dx;
                    y += dy;
                
                }
            
            }else if(leftFree || rightFree){
            
                int dx = 0;
                
                if(leftFree && !rightFree)
                    dx = -1;
                else if(rightFree && !leftFree)
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
        if(particleMap[x][y] != null){
            particleMap[x][y].x = oldx;
            particleMap[x][y].y = oldy;
        }
        
        //px = oldx;
        //py = oldy;
        
        Particle temp = particleMap[oldx][oldy];
        particleMap[oldx][oldy] = particleMap[x][y];
        particleMap[x][y] = temp;
            
    }

}
