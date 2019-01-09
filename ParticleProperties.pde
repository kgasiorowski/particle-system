static class ParticleProperties{

    // Name of the particle type (debugging)
    String name;
    // Denser particles should sink, less dense particles should float
    int density;
    // Color of the particle
    color prt_color;
    // How quickly particles "cascade"
    float stick_factor;
    // How quickly particles disperse on the ground
    float float_factor;
    // How quickly particles disperse in the air
    float drift_factor;
    // Negates most of the above properties besides color and name
    boolean isStatic;

    ParticleProperties(){}

    ParticleProperties(String _name){
        name = _name;
     }
     
     public ParticleProperties setName(String s){
         name = s;
         return this;
     }
     
     public ParticleProperties setDensity(int d){
         density = d;
         return this;
     }

    public ParticleProperties setColor(color c){
        prt_color = c;
        return this;
    }

    public ParticleProperties setStickFactor(float s){
        stick_factor = s;
        return this;
    }
    
    public ParticleProperties setFloatFactor(float f){
        float_factor = f;
        return this;
    }
    
    public ParticleProperties setDriftFactor(float d){
        drift_factor = d;
        return this;
    }

    public ParticleProperties setStatic(boolean b){
        isStatic = b;
        return this;
    }

}

public enum PARTICLE_TYPE{

    SAND(new ParticleProperties("Sand")
                .setDensity(3)
                .setColor(0xFFFFEA82)
                .setStickFactor(.1)
                .setFloatFactor(.01)
                .setDriftFactor(.1)
                .setStatic(false)),
    
    WATER(new ParticleProperties("Water")
                .setDensity(1)
                .setColor(0xFF0033CC)
                .setStickFactor(0)
                .setFloatFactor(1)
                .setDriftFactor(.5)
                .setStatic(false)),
    
    CONCRETE(new ParticleProperties("Concrete")
                .setStatic(true)
                .setColor(0xFF8B949A)),
    
    SALT(new ParticleProperties("Salt")
                .setStatic(false)
                .setColor(0xFFFFFFFF)
                .setStickFactor(.1)
                .setFloatFactor(.01)
                .setDriftFactor(.1)
                .setDensity(3)),
    
    SALTWATER(new ParticleProperties("Saltwater")
                .setStatic(false)
                .setColor(0xFF99CCFF)
                .setStickFactor(0)
                .setFloatFactor(1)
                .setDriftFactor(.1)
                .setDensity(2)),
    
    PLANT(new ParticleProperties("Plant")
                .setStatic(true)
                .setColor(0xFF48F442));
    
    private final ParticleProperties p;
    private PARTICLE_TYPE(final ParticleProperties _p){p = _p;}
    public ParticleProperties getProps(){return p;}

}
//Set default to sand
PARTICLE_TYPE current_type = PARTICLE_TYPE.SAND;
