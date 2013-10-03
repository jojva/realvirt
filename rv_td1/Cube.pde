class Material {
  PImage[] tex;
  int uv_factor;

  Material(String[] filenames, int _uv_factor) {
    tex = new PImage[3];
    tex[0] = loadImage(filenames[0]);
    tex[1] = loadImage(filenames[1]);
    tex[2] = loadImage(filenames[2]);
    uv_factor = _uv_factor;
  }
}

class Cube {
  color papier_peint_disco;
  Material material;
  PMatrix3D transform;
  
  Cube(int id, Material _m, PMatrix3D _t) {
    material = _m;
    transform = _t;
    id = count++;
    papier_peint_disco = color(id,0,0);
  }

  void displayText() {
    pushMatrix();
    applyMatrix(transform);

    beginShape(QUADS);
    texture(material.tex[0]);

    // +Z "front" face
    vertex( 0, 0, 1, 0, 0);
    vertex( 1, 0, 1, material.uv_factor, 0);
    vertex( 1, 1, 1, material.uv_factor, material.uv_factor);
    vertex( 0, 1, 1, 0, material.uv_factor);

    // -Z "back" face
    vertex( 1, 0, 0, 0, 0);
    vertex( 0, 0, 0, material.uv_factor, 0);
    vertex( 0, 1, 0, material.uv_factor, material.uv_factor);
    vertex( 1, 1, 0, 0, material.uv_factor);

    // +X "right" face
    vertex( 1, 0, 1, 0, 0);
    vertex( 1, 0, 0, material.uv_factor, 0);
    vertex( 1, 1, 0, material.uv_factor, material.uv_factor);
    vertex( 1, 1, 1, 0, material.uv_factor);

    // -X "left" face
    vertex( 0, 0, 0, 0, 0);
    vertex( 0, 0, 1, material.uv_factor, 0);
    vertex( 0, 1, 1, material.uv_factor, material.uv_factor);
    vertex( 0, 1, 0, 0, material.uv_factor);
    endShape();

    beginShape(QUADS);
    texture(material.tex[1]);
    // +Y "bottom" face
    vertex( 0, 1, 1, 0, 0);
    vertex( 1, 1, 1, material.uv_factor, 0);
    vertex( 1, 1, 0, material.uv_factor, material.uv_factor);
    vertex( 0, 1, 0, 0, material.uv_factor);
    endShape();
    
    beginShape(QUADS);
    texture(material.tex[2]);
    // -Y "top" face
    vertex( 0, 0, 0, 0, 0);
    vertex( 1, 0, 0, material.uv_factor, 0);
    vertex( 1, 0, 1, material.uv_factor, material.uv_factor);
    vertex( 0, 0, 1, 0, material.uv_factor);
    endShape();

    popMatrix();
  }
  
  void drawCube(PGraphics buffer)
  {
 
  }
  
  void drawBuffer(PGraphics buffer)
  {
      buffer.fill(c);
      drawCube(buffer);
  }
  
    void display() {
    pushMatrix();
    applyMatrix(transform);

    beginShape(QUADS);
    fill(red(papier_peint_disco), green(papier_peint_disco), blue(papier_peint_disco));

    // +Z "front" face
    vertex( 0, 0, 1, 0, 0);
    vertex( 1, 0, 1, 1, 0);
    vertex( 1, 1, 1, 1, 1);
    vertex( 0, 1, 1, 0, 1);

    // -Z "back" face
    vertex( 1, 0, 0, 0, 0);
    vertex( 0, 0, 0, 1, 0);
    vertex( 0, 1, 0, 1, 1);
    vertex( 1, 1, 0, 0, 1);

    // +X "right" face
    vertex( 1, 0, 1, 0, 0);
    vertex( 1, 0, 0, 1, 0);
    vertex( 1, 1, 0, 1, 1);
    vertex( 1, 1, 1, 0, 1);

    // -X "left" face
    vertex( 0, 0, 0, 0, 0);
    vertex( 0, 0, 1, 1, 0);
    vertex( 0, 1, 1, 1, 1);
    vertex( 0, 1, 0, 0, 1);
    endShape();

    beginShape(QUADS);
    fill(red(papier_peint_disco), green(papier_peint_disco), blue(papier_peint_disco));
    // +Y "bottom" face
    vertex( 0, 1, 1, 0, 0);
    vertex( 1, 1, 1, 1, 0);
    vertex( 1, 1, 0, 1, 1);
    vertex( 0, 1, 0, 0, 1);
    endShape();
    
    beginShape(QUADS);
   fill(red(papier_peint_disco), green(papier_peint_disco), blue(papier_peint_disco));
    // -Y "top" face
    vertex( 0, 0, 0, 0, 0);
    vertex( 1, 0, 0, 1, 0);
    vertex( 1, 0, 1, 1, 1);
    vertex( 0, 0, 1, 0, 1);
    endShape();

    popMatrix();
  }
}

