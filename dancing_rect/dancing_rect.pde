int rot = 50;
int max_r = 4;
float sqrt2 = sqrt(2);

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

  draw_rectangle(1);
  popMatrix();
  i++;
}

// draw a rectangle
void draw_rectangle( int step ) {
  float ratio = pow( 2, step );

  rotate(2*PI * (1+ i % rot) / rot );
  stroke(255);
  fill(102);
  rectMode(CENTER);
  rect(0,0,(width * sqrt2 )/ratio,(height * sqrt2 )/ratio );

  println( "DBG> step: " + step + " ratio: " + ratio );
  if( step < max_r ) {
    draw_rectangle( ++step ); 
  }
}

