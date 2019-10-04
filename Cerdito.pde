class Piggy1 {
  Body body;
  
  float w;
  float h;
  PImage img;
  int angle;
   boolean delete = false;  //Sirve para indicar si se conserva o se borra el objeto
  float r;
  
  //Constructores
  Piggy1(float x, float y) {
    w = 50;
    h = 50;
    
    img = loadImage("cerdi1.png");
    makeBody(new Vec2(x,y),w,h);
  }

  void killBody(){
    box2d.destroyBody(body);
  }
  //El objeto debe destruirse
   void delete() {
    delete = true;
  }

  // Dibujo de cerdi
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    
    

    //rectMode(CENTER);
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(-a);
      //fill(175);
      //stroke(0);
      //rect(0,0,w,h);
      image(img,0,0,w,h);
    popMatrix();
  }
  
  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }

}
