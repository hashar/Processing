int rot = 200;
int max_r = 3;
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

  stroke(255);
  
  fill( 255 * step/max_r );

  rectMode(CENTER);
  println( "loop for step #" + step );
  for(int c=0; c<step; c++) {
    for(int l=0; l<step; l++) {
      float wr = (width * sqrt2 )/ratio;
      float hr =  (height * sqrt2 )/ratio;
      
      pushMatrix();
        //println( "c,l: " + c + ","+ l + "  step: " + step  );
        rotate(2*PI * (1 + i % rot) / rot );
        translate( wr * c, hr * l );
        rotate(2*PI * (1 + i % rot) / rot * step);
        rect(0,0,wr,hr);
      popMatrix();
    }
  }

  //println( "DBG> step: " + step + "/" + max_r + " ratio: " + ratio );
  if( step < max_r ) {
    draw_rectangle( ++step ); 
  }
}


