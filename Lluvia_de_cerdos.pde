
//Importación de librerías;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import processing.sound.*;


SoundFile sonido;

//Box2d
Box2DProcessing box2d;

//Arraylist de mis puerquitos;
ArrayList<Piggy> piggies;



//Pantalla
int pantalla = 0;
PImage fondo1;
PImage sueli1;
PImage inst;
PImage fin;
PImage canasta;



void setup(){
  size(800,500);
 
sonido = new SoundFile(this, "sonido.mp3");
sonido.play();
  
  //Inicializando mundo;
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  //Configuración de la gravedad;
  box2d.setGravity(0, -20);
  
 

  
  piggies = new ArrayList<Piggy>();


  
 
}



void draw(){

  box2d.step();
 
   if(pantalla == 0){
 fondo1 = loadImage("piggyrain1.png");
  image(fondo1,0,0);
    textSize(10);
    text("Presiona (M) para continuar", 600,480);
    if (key == 'm' || key == 'M'){
      pantalla = 1;
    }
  }
  
  if(pantalla == 1){
    inst = loadImage("inst.png");
    image(inst,0,0);
    fill(155,8,116);
     textSize(100);
    text("Instrucciones", 50,100);
     textSize(20);
     text("Presiona el mouse para poder generar tus cerditos",100, 250);
     fill(255);
    textSize(10);
    text("Presiona (N) para continuar", 650,490);
        if (key == 'n' || key == 'N'){
      pantalla = 2;
  }
}
{
if(pantalla == 2){

    sueli1 = loadImage("sueli2.png");
    image(sueli1,0,0);
      canasta = loadImage("Canastilla.png");
    image(canasta,10,150);
    fill(208,95,177);
    textSize(15);
    text("Presiona y mira tus cerditos", 300,20);
    fill(255);
    textSize(10);
    text("Presiona (H) para salir",650,490);
    
     if(mousePressed)
  if (random(1) < 0.1) {
    Piggy p = new Piggy(random(width),10);
    piggies.add(p);
  }
  
    //Aparición;
  for (Piggy b: piggies) {
    b.display();
  
  }
}

    
    textSize(50);
 
    if (key == 'h' || key == 'H'){
      pantalla =3;

}
}

if(pantalla == 3){
    fin = loadImage("fin.png");
    image(fin,0,0);
    
    
    textSize(20);
    text("CERRAR, presiona (ESC)", 100,200);
    text("Seguir creando cerditos, presiona (TAB)", 400,450);
    if(key == TAB){
      pantalla = 0;
}
}
}
 

class Piggy {
  Body body;
  
  float w;
  float h;
  PImage img;
  int angle;
  
  //Constructores
  Piggy(float x, float y) {
    w = 50;
    h = 50;
    
    img = loadImage("cerdi1.png");
    makeBody(new Vec2(x,y),w,h);
  }

  void killBody(){
    box2d.destroyBody(body);
  }
  
  //Dibujando el cerdito
  void display() {
    //Posición;
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //rot;
    float a = body.getAngle();
    
    

    //rectMode(CENTER);
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(-a);
      //fill(175);
      stroke(0);
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
