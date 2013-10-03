import java.lang.Math;

Camera cam;

ArrayList<Cube> cubes;

int id = -1;
boolean updown = true;
int cpt =0;

PGraphics pg;
int mode=1;

void setup() {
  size(640, 360, P3D);

  textureMode(NORMAL);
  textureWrap(REPEAT);

  textMode(SHAPE);
  
  pg = createGraphics(40, 40);
  
  
  cam = new Camera();

  // Create cubes and their materials
  cubes = new ArrayList<Cube>();

  String[] filenames_sand = { 
    "sand.png", "sand.png", "sand.png"
  };
  Material sand = new Material(filenames_sand, 1);
  String[] filenames_stonebrick = { 
    "stonebrick.png", "stonebrick.png", "stonebrick.png"
  };
  
   String[] filenames_stonebrick_mossy = { 
    "stonebrick_mossy.png", "stonebrick_mossy.png", "stonebrick_mossy.png"
  };
  Material stonebrick = new Material(filenames_stonebrick, 2);
  Material stonebrick_mossy = new Material(filenames_stonebrick_mossy, 2);
  for (int i=0; i < 2; i++) {
    for (int j=-10; j < 10; j++) {
      for (int k=-10; k < 10; k++) {
        PMatrix3D m = new PMatrix3D();
        m.translate(j, i+1, k);
        if (i==1) 
          cubes.add(new Cube(sand, m));
        else
         { 
          if((int)(Math.random()*10)==1)
            cubes.add(new Cube(stonebrick_mossy, m));
          else
           cubes.add(new Cube(stonebrick, m));
        }
    }
   }
  }

  String[] filenames_tnt = { 
    "tnt_side.png", "tnt_bottom.png", "tnt_top.png"
  };
  Material tnt = new Material(filenames_tnt, 1);
  PMatrix3D m = new PMatrix3D();
  m.translate(2, 0, -1);
  cubes.add(new Cube(tnt, m));
}
  void keyPressed() 
  {
    int vitesse =10;
   switch(key) 
   {
    case('z'):
    
       cam.transZ-=cos(cam.rotY)*vitesse;
       cam.transX+=sin(cam.rotY)*vitesse;
      break;
    case('d'):
       cam.transZ+=sin(cam.rotY)*vitesse;
       cam.transX+=cos(cam.rotY)*vitesse;
    break;
    case('s'):
        cam.transZ+=cos(cam.rotY)*vitesse;
        cam.transX-=sin(cam.rotY)*vitesse;
    break;
    case('q'):
      cam.transZ-=sin(cam.rotY)*vitesse;
      cam.transX-=cos(cam.rotY)*vitesse;
      break;
  }
  
  }
void draw() {
  // Clean screen and draw geometry
  background(0);
  drawScene(false);

  cam.display();
}

void drawScene(boolean id_mode) {
  cam.applyMatrix(mode);

  drawAxes();

  scale(90);
  noStroke();
  
 pg.beginDraw();
  pg.background(100);
  pg.noStroke();

  image(pg, 9, 30); 
  image(pg, 51, 30);
  // Draw cubes
  
  
  for (int i=0; i<cubes.size(); i++) {
    cubes.get(i).display();
  }

  if(updown)
  {
    cubes.get(cubes.size()-1).transform.translate(0,-0.1,0);
    cpt++;
    if(cpt==30)
      updown =false;
  }
  else
  {
    cubes.get(cubes.size()-1).transform.translate(0,0.1,0);
    cpt--;
    if(cpt==0)
      updown =true;
  }
    pg.endDraw();
}

void drawAxes() {
  // 3D axes
  strokeWeight(1);
  textSize(20);
  stroke(255, 0, 0);
  line(0, 0, 0, 20, 0, 0);
  fill(255, 0, 0);
  text('x', 25, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 20, 0);
  fill(0, 255, 0);
  text('y', 5, 25, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 20);
  fill(0, 0, 255);
  text('z', -5, -5, 22);
}

void mouseDragged() {
  cam.update(mouseX, mouseY);
  mode=0;
}

void mouseMoved() {
  cam.update(mouseX, mouseY);
  mode=1;
  
}

