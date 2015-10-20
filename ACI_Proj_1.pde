import ddf.minim.*;
import java.util.*;

AmpListener ampListener;
World world;

boolean key_up;
boolean key_down;
boolean key_left;
boolean key_right;
boolean key_w;
boolean key_s;
boolean key_a;
boolean key_d;
boolean key_space;

int radius = 100;

void setup()
{
  // project settings
  //size(800, 450);  best in 1600x900
  fullScreen();
  frameRate(60);

  // sound
  ampListener = new AmpListener();

  world = new World();

  // add the legendary, the one and only, the supreme, MR ROLLS
  world.mrRolls = new Rolley(height*0.1, new PVector(width*0.2, height*0.8), new PVector(0, 0), new PVector(0, 0));

  // add static rect objects
  // (x,y,w,h)
  float px = width*0.1;
  float py = height/2;
  float pw = width*0.7;
  float ph = height*0.2;
  float pr = height*0.2;

  px += pw + width*0.2;
  pw = width*0.2;
  py = height-ph;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  py -= ph;
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  py -= ph;
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  py += ph;
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  py += ph;
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += width/2;
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += width/5;
  py -= height/5;
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += width/5;
  py -= height/5;
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += width/5;
  py -= height/5;
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += width/2;
  py += width/5;
  pw = width/2;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += pw;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  px += pw+width/5;
  py += ph;
  world.objs.add(new StaticObject(px, py, pw, ph));
  world.colls.add(new Collectable(new PVector(px+pw/2, py-ph/2)));
  
  // circle phase
  px += width;
  py = height;
  world.objsRound.add(new StaticObjectRound(new PVector(px,py), pr));
  world.colls.add(new Collectable(new PVector(px, py-pr*2)));
  px += pr;
  py -= pr/2;
  world.objsRound.add(new StaticObjectRound(new PVector(px,py), pr));
  world.colls.add(new Collectable(new PVector(px, py-pr*2)));
  px += pr;
  py -= pr/2;
  world.objsRound.add(new StaticObjectRound(new PVector(px,py), pr));
  world.colls.add(new Collectable(new PVector(px, py-pr*2)));
  px += pr;
  py -= pr/2;
  world.objsRound.add(new StaticObjectRound(new PVector(px,py), pr));
  world.colls.add(new Collectable(new PVector(px, py-pr*2)));

  // add static circle objects
  // ((x,y),r)
  //world.objsRound.add(new StaticObjectRound(new PVector(width/2, height/2), width*0.1));


  // key bindings
  key_up = false;
  key_down = false;
  key_left = false;
  key_right = false;
  key_w = false;
  key_s = false;
  key_a = false;
  key_d = false;
  key_space = false;
}

void draw()
{
  background(color(0, 128, 128));

  world.mrRolls.inflate(ampListener.getBlowingIntensity());

  println(ampListener.getBlowingIntensity());

  world.updatePositions();
  world.checkOverlaps();
  world.checkCollisions();
  world.recenter();

  world.drawWorld();
  world.drawUI();

  //println("Pos: x=" + world.mrRolls.position.x + " y=" + world.mrRolls.position.y +
  //" Vel x=" + world.mrRolls.velocity.x + " y=" + world.mrRolls.velocity.y +
  //" Acc x=" + world.mrRolls.acceleration.x + " y=" + world.mrRolls.acceleration.y);
}

void keyPressed() 
{
  key_up = keyCode    == UP    ? true : key_up;
  key_down = keyCode  == DOWN  ? true : key_down;
  key_left = keyCode  == LEFT  ? true : key_left;
  key_right = keyCode == RIGHT ? true : key_right;
  key_w = keyCode     == 'W'   ? true : key_w;
  key_s = keyCode     == 'S'   ? true : key_s;
  key_a = keyCode     == 'A'   ? true : key_a;
  key_d = keyCode     == 'D'   ? true : key_d;
  key_space = keyCode == ' '   ? true : key_space;

  if (keyCode == ' ')
  {
    world.mrRolls.position.y -= world.mrRolls.radius-world.mrRolls.orgRadius;
    world.mrRolls.radius =  world.mrRolls.orgRadius;
  }
}

void keyReleased() 
{
  key_up = keyCode    == UP    ? false : key_up;
  key_down = keyCode  == DOWN  ? false : key_down;
  key_left = keyCode  == LEFT  ? false : key_left;
  key_right = keyCode == RIGHT ? false : key_right;
  key_w = keyCode     == 'W'   ? false : key_w;
  key_s = keyCode     == 'S'   ? false : key_s;
  key_a = keyCode     == 'A'   ? false : key_a;
  key_d = keyCode     == 'D'   ? false : key_d;
  key_space = keyCode == ' '   ? false : key_space;
}

class AmpListener 
{
  Minim minim;
  AudioInput in;

  final int baseLineTime = 2000;
  int startTime;
  int count;
  float baseLine = 0.02;
  boolean isBaseDone = true;

  final int maxLineTime = 4000;
  int startTimeMax;
  int countMax;
  float maxLine = 0.15;
  boolean isMaxDone = true;

  AmpListener() 
  {
    minim = new Minim(this);
    in = minim.getLineIn(Minim.STEREO, 2048);

    startTime = millis();
    count = 0;
  }

  boolean isBlowing() {
    if (isBaseDone) {
      double b = 0;
      double c = 0;
      for (int i = 0; i < in.bufferSize() - 1; i++)
      {
        b += Math.abs(in.left.get(i));
        c++;
      }

      double avg = b/c;

      return avg > baseLine*2;
    } else return false;
  }

  float getBlowingIntensity() {

    float b = 0;
    float c = 0;
    for (int i = 0; i < in.bufferSize() - 1; i++)
    {
      b += Math.abs(in.left.get(i));
      c++;
    }

    float avg = b/c;

    //println(avg);

    return map(avg, baseLine, maxLine, 0.0, 100.0);
  }
}

class World 
{
  final int of = 70; // overlap factor
  final int speed = 1;
  final PVector gravity = new PVector(0, 0.3);
  final int speedLimit = 30;
  final float friction = 0.95;
  final float bf = 0.5; // bounce factor

  float worldPosition = 0;

  Rolley mrRolls;
  List<StaticObject> objs;
  List<Collectable> colls;
  List<StaticObjectRound> objsRound;

  float score = 0;

  World() 
  {
    objs = new ArrayList<StaticObject>();
    colls = new ArrayList<Collectable>();
    objsRound = new ArrayList<StaticObjectRound>();
  }

  void updatePositions()
  {
    mrRolls.acceleration.x = 0;
    mrRolls.acceleration.y = 0;

    //if (key_w || key_up) mrRolls.acceleration.y    = -speed;
    //if (key_s || key_down) mrRolls.acceleration.y  = speed;
    if (key_a || key_left) mrRolls.acceleration.x  = -speed;
    if (key_d || key_right) mrRolls.acceleration.x = speed;

    // add gravity
    mrRolls.acceleration.add(gravity);

    // update velocity with acceleration
    mrRolls.velocity.add(mrRolls.acceleration);

    // apply friction to velocity.x
    mrRolls.velocity.x *= friction;

    // limit velocity to max speed
    mrRolls.velocity.limit(speedLimit);

    // update position with velocity
    mrRolls.position.add(mrRolls.velocity);

    // update angle based on x componenet of v
    mrRolls.angle -= (mrRolls.velocity.x)/(mrRolls.radius*2*PI)*(2*PI);
  }

  // Overlap object detection without relocation
  void checkOverlaps()
  {
    checkCollectables();
  }

  // Collisions = overlapping with object relocation
  void checkCollisions() 
  {
    checkScreenBoundCollisions();
    checkStaticObjectCollisions();
    checkStaticObjectRoundCollisions();
  }

  void checkCollectables() {
    for (Collectable coll : colls) 
    {
      if (mrRolls.position.dist(coll.position) < mrRolls.radius+coll.radius)
      {
        score += coll.value;
        coll.destroy();
      }
    }
  }

  void checkScreenBoundCollisions() {
    if (mrRolls.position.x-mrRolls.radius < 0) 
    {
      mrRolls.position.x = mrRolls.radius;
      mrRolls.velocity.x *= -bf;
    }
    if (mrRolls.position.x+mrRolls.radius > width) 
    {
      mrRolls.position.x = width-mrRolls.radius;
      mrRolls.velocity.x *= -bf;
    }
    if (mrRolls.position.y-mrRolls.radius < 0)
    {
      mrRolls.position.y = mrRolls.radius;
      mrRolls.velocity.y *= -bf;
    }
    if (mrRolls.position.y+mrRolls.radius > height)
    {
      mrRolls.position.y = height-mrRolls.radius;
      mrRolls.velocity.y *= -bf;
    }
  }

  void checkStaticObjectCollisions() {
    for (StaticObject obj : objs) 
    {
      // check if overlapping
      if (circRectIntersect(mrRolls.position.x, mrRolls.position.y, mrRolls.radius, 
        obj.x, obj.y, obj.w, obj.h)) {
        float cx = mrRolls.position.x;
        float cy = mrRolls.position.y;
        float cr = mrRolls.radius;

        float bx = obj.x;
        float by = obj.y;
        float bw = obj.w;
        float bh = obj.h;

        float f = 30;

        // top
        if (cy+cr < by + f) 
        {
          mrRolls.position.y = by-cr;
          mrRolls.velocity.y *= -bf;
        }

        //bottom
        else if (cy - cr > by + bh - f)
        {
          mrRolls.position.y = by+bh+cr;
          mrRolls.velocity.y *= -bf;
        }

        //left
        else if (cx+cr < bx + f)
        {
          mrRolls.position.x = bx-cr;
          mrRolls.velocity.x *= -bf;
        }

        //right
        else if (cx - cr > bx + bw - f)
        {
          mrRolls.position.x = bx+bw+cr;
          mrRolls.velocity.x *= -bf;
        }
      }
    }
  }

  boolean circRectIntersect(float cx, float cy, float cr, float rx, float ry, float rw, float rh)
  {

    float cdx = abs(cx - rx - rw/2);
    float cdy = abs(cy - ry - rh/2);

    if (cdx > (rw/2 + cr)) return false;
    if (cdy > (rh/2 + cr)) return false;

    if (cdx <= (rw/2)) return true;
    if (cdy <= (rh/2)) return true;

    float cd = sq(cdx - rw/2) + sq(cdy - rh/2);

    return (cd <= sq(cr));
  }

  void checkStaticObjectRoundCollisions() {
    for (StaticObjectRound objRound : objsRound) {
      // check if colliding
      if (mrRolls.position.dist(objRound.position) < mrRolls.radius+objRound.radius) {
        // move Mr Rolls back outside

        float c1x = mrRolls.position.x;
        float c1y = mrRolls.position.y;
        float c1r = mrRolls.radius;

        float c2x = objRound.position.x;
        float c2y = objRound.position.y;
        float c2r = objRound.radius;

        float angle = asin((c1x-c2x)/mrRolls.position.dist(objRound.position));

        float c3x = sin(angle)*(c1r+c2r);
        float c3y = cos(angle)*(c1r+c2r);

        if (c1y < c2y) c3y *= -1;

        mrRolls.position.x = c3x+c2x;
        mrRolls.position.y = c3y+c2y;

        // set v to the mag of old v times bf reflected over the perp vector at the intersection
        //.
        //.
        //.
        // nope
      }
    }
  }

  // keep mr rolls in the center, and move everything else
  void recenter()
  {
    float x1 = mrRolls.position.x;
    float x2 = width/2;

    float diff = x2-x1;

    worldPosition += diff;

    for (StaticObject obj : objs) obj.x += diff;
    for (StaticObjectRound objRound : objsRound) objRound.position.x += diff;
    for (Collectable coll : colls) coll.position.x += diff;

    mrRolls.position.x = width/2;
  }

  void drawWorld() 
  {
    drawBackground();

    mrRolls.updateImage();

    for (StaticObject obj : objs) obj.updateImage();
    for (StaticObjectRound objRound : objsRound) objRound.updateImage();
    for (Collectable coll : colls) coll.updateImage();
  }

  void drawBackground() {
    fill(128, 82, 21);
    rect(0, height/2, width, height/2);

    fill(0, 0, 0);
    float r = 5;
    for (float i = width/15; i <= width+1000; i+=width/15) ellipse(i+((worldPosition*15/2)%width/15)-r/2, height/2, r, r);
    r = 10;
    for (float i = width/10; i <= width+1000; i+=width/10) ellipse(i+((worldPosition*10/1.75)%width/10)-r/2, height/1.75, r, r);
    r = 20;
    for (float i = width/8; i <= width+1000; i+=width/8) ellipse(i+((worldPosition*8/1.5)%width/8)-r/2, height/1.5, r, r);
    r = 40;
    for (float i = width/5; i <= width+1000; i+=width/5) ellipse(i+((worldPosition*5/1.25)%width/5)-r/2, height/1.25, r, r);
    r = 80;
    for (float i = width/3; i <= width+1000; i+=width/3) ellipse(i+((worldPosition*3/1)%width/3)-r/2, height/1, r, r);
    
    fill(color(255,255,255));
    for (float i = width/15; i <= width+160*2; i+=width/15) ellipse(i+((worldPosition*15/3)%(width)/15)-80, height/4, 160,40);
    
  }

  void drawUI()
  {
    fill(0, 0, 0);
    textSize(width*0.05); 
    text("Score: " + score, width*0.05, height*0.1);
  }
}

// He's the one who rolls
class Rolley 
{
  float radius;
  final float orgRadius;
  float angle;

  PVector position;
  PVector velocity;
  PVector acceleration;

  color c = color(255, 255, 0);

  boolean isSucking = false;

  float prevFrameX;

  Rolley(float rad, PVector pos, PVector vel, PVector acc) {
    radius       = rad;
    angle        = 0;
    position     = pos;
    velocity     = vel;
    acceleration = acc;

    orgRadius = radius;

    prevFrameX = pos.x;
  }

  void updateImage() 
  {
    // draw main body
    fill(c);
    ellipse(position.x, position.y, radius*2, radius*2);

    // draw eyes
    fill(color(0, 0, 0));
    ellipse(position.x+sin(angle)*radius/2, position.y+cos(angle)*radius/2, radius*0.25, radius*0.25);
    ellipse(position.x+sin(angle+PI/2)*radius/2, position.y+cos(angle+PI/2)*radius/2, radius*0.25, radius*0.25);

    // draw smile
    if (isSucking) {
      ellipse(position.x+sin(angle+PI*1.25)*radius/2, position.y+cos(angle+PI*1.25)*radius/2, radius*0.5, radius*0.5);
    } else {
      strokeWeight(4);
      line(position.x+sin(angle+PI)*radius/2, position.y+cos(angle+PI)*radius/2, position.x+sin(angle+PI*1.5)*radius/2, position.y+cos(angle+PI*1.5)*radius/2);
      strokeWeight(4);
    }
  }

  void inflate(float intensity) {
    if (intensity > 50) {
      isSucking = true;
      radius += 2;
    } else isSucking = false;
  }
}

// does not roll
class StaticObject 
{
  float x;
  float y;
  float w;
  float h;

  color c = color(0, 255, 0);

  StaticObject(float x, float y, float w, float h) 
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void updateImage() 
  {
    fill(c);
    rect(x, y, w, h);
  }
}

class StaticObjectRound 
{
  PVector position;
  float radius;

  color c = color(0, 255, 0);

  StaticObjectRound(PVector pos, float rad) 
  {
    position = pos;
    radius = rad;
  }

  void updateImage() 
  {
    fill(c);
    ellipse(position.x, position.y, radius*2, radius*2);

    fill(color(255, 0, 0));
    //ellipse(position.x, position.y, 10, 10);
  }
}

class Collectable 
{
  PVector position;
  float radius = height*0.05;
  float value = 100;
  color c = color(255, 255, 0);

  Collectable(PVector pos)
  {
    position = pos;
  }

  void destroy() {
    position.y = -radius-height-420;
  }

  void updateImage() 
  {
    fill(c);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}