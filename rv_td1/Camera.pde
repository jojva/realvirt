import javax.media.opengl.GL2;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.PointerInfo;
import java.awt.MouseInfo;
import java.awt.Point;


Robot robby;
PGL pgl;
GL2 gl;

int window_deco = 22;

class Camera {

  float rotX;
  float rotY;
  float transX; 
  float transY;
  float transZ;

  float aim_dist = -400; 

  // Previous mouse position
  int lastX; 
  int lastY;

  Camera() {
    noCursor();
    try
    {
      robby = new Robot();
    }
    catch (AWTException e)
    {
      println("Robot class not supported by your system!");
      exit();
    }
    robby.mouseMove(frame.getLocation().x+width/2, frame.getLocation().y+ height/2+window_deco);

    rotX = 0;
    rotY = 0;
    transX = 0;
    transY = 0;
    transZ = aim_dist;
    //transZ = 0;
    lastX = width/2;
    lastY = height/2;
  }
  
  void applyMatrix(int mode) 
  {
    resetMatrix();
    switch(mode) {
    case 0:
      translate(-transX, -transY, -transZ);
      rotateX(rotX);
      rotateY(rotY);

      break;
    case 1:
      rotateX(rotX);
      rotateY(rotY);
      translate(-transX, -transY, -transZ);
      break;
    default:
      break;
    }
  }
  
  void update(int x, int y) {
    float rate = PI/height;
    float diffX = x - lastX;
    float diffY = lastY - y;
    lastX = x;
    lastY = y;
    rotX += diffY * rate;
    rotY += diffX * rate;
  }

  void display() {
    // Draw camera aim as overlay
    camera();
    pgl = beginPGL();
    gl = pgl.gl.getGL2();
    gl.glDisable(gl.GL_DEPTH_TEST);
    gl.glClear(gl.GL_DEPTH_BUFFER_BIT);
    gl.glDisable(gl.GL_BLEND);
    endPGL();

    strokeWeight(4);
    stroke(100, 100, 100);
    pushMatrix();
    translate(width/2, height/2);
    line(-10, 0, 10, 0);
    line(0, -10, 0, 10);
    popMatrix();

    // Make sure the mouse pointer wrap horizontally and stay inside the frame vertically 
    PointerInfo info = MouseInfo.getPointerInfo();
    Point p = info.getLocation();
    if (p.getX() < frame.getLocation().x) {
      robby.mouseMove(frame.getLocation().x + width, (int) p.getY());
    }
    if (p.getX() > frame.getLocation().x+width) {
      robby.mouseMove(frame.getLocation().x, (int) p.getY());
    }
    if (p.getY() < frame.getLocation().y+window_deco) {
      robby.mouseMove((int) p.getX(), frame.getLocation().y+window_deco);
    }
    if (p.getY() > frame.getLocation().y+height+window_deco) {
      robby.mouseMove((int) p.getX(), frame.getLocation().y+height+window_deco);
    }
  }
  


}

