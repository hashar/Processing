int rot = 50;

void setup() {
  size(500,500);
  background(0,0,0);
  smooth();
  frameRate(20);
}


/*
 TODO : recursion du type rectangle( r_level );
 puis rotation en fonction du niveau de recursivité;

*/

int i=0;
void draw() {
  fill(0,50);
  rectMode(CORNER);
  rect(0,0,width,height);
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(2*PI * (1+ i % rot) / rot );
  draw_rectangle();
  popMatrix();
  i++;
}

// draw a rectangle
void draw_rectangle() {
  stroke(255);
  fill(102);
  rectMode(CENTER);
  rect(0,0,200,200);
  
}

