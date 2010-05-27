// Number of recursions
int max_r = 3;

// Canvas width and height
int canvas_size = 500;

// precomputation (do not change)
float sqrt2 = sqrt(2);

// usual program wide initializations
void setup() {
  size(canvas_size,canvas_size);
  background(0,0,0);
  smooth();
  frameRate(60);
  rectMode(CENTER);
}

void draw() {
  fade_out_screen();
 
  translate(width/2,height/2);
  draw_rectangle(0, width*sqrt2/2, radians( frameCount % 360 ) );
}

void draw_rectangle( int step, float my_size, float angle ) {
  // scale to fit in parent diagonale
  float my_diag     = my_size * sqrt2;
  float childs_size = my_diag / 4;
  float childs_diag = childs_size * sqrt2;

  // colours
  stroke(255); fill( 126 + 126 * step / max_r, 127 );  
  rotate( angle );
  rect( 0, 0, my_size, my_size );

  step++;
  if( step >= max_r ) { return; /* exit recursion */ }
  
  pushMatrix();
    float [][] xy = {
      {  my_size/4 ,  my_size/4  },
      { -my_size/2 ,          0  },
      {          0 , -my_size/2  },
      {  my_size/2 ,          0  },
    };
    for( int tr_num=0; tr_num<4; tr_num++ ) {
      translate( xy[tr_num][0], xy[tr_num][1] );

      pushMatrix();
        draw_rectangle(step,childs_size, angle);
      popMatrix();
    }
  popMatrix();
}


// Draw a transparent black rectangle to fade out smoothly
void fade_out_screen() {
  fill(0,10);
  stroke(0);
  rect(width/2,height/2,width,height);
}
