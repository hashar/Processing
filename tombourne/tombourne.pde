int w = 400, h = 600;

int n_obstacles = w * h / 70;
pix[] obstacles = new pix[n_obstacles];

ArrayList snakes;
n_snakes = int( w / 30 );

// Let you "zoom" pixels
weight = 3; // keep it odd

void setup() {
  size(w,h,P2D);
  background(0,0,0);
  colorMode( HSB, 255 );
  smooth();
  frameRate(60);

  rectMode( CENTER );
  //strokeWeight( weight );

  init_obstacles();
  draw_obstacles();

  snakes = new ArrayList();
  while( n_snakes-- ) {
    snakes.add( new Snake() );
  }
}

void draw() {
	for( int i = snakes.size() - 1; i>=0; i-- ) {
		Snake snake = (Snake) snakes.get(i);
		snake.fall();
		if( snake.blocked ) {
			snakes.remove(i);
		}
	}
}


class Snake {
	int x;
	int y;
	color c;
	boolean blocked;

	// Constructor
	Snake() {
		x = random( w );
		y = 0;
		c = color( random(255), 255, 255 );
		blocked = false;
	}

	void fall() {
		if( blocked ) {
			return;
		}


		if( get(x,y+weight) == color(0) ) {
			y += weight;
			draw();
			return;
		}

		obstacleOnLeft  = ( get(x-weight,y) != color(0) );
		obstacleOnRight = ( get(x+weight,y) != color(0) );

		if( !obstacleOnLeft && !obstacleOnRight ) {
			// choose randomly between left and right
			if( 1 == int( random(2) ) ) {
				x += weight;
			} else {
				x -= weight;
			}
		} else if( obstacleOnLeft && obstacleOnRight ) {
			blocked = true;
			return;
		} else if( obstacleOnLeft ) {
			x += weight; // go to the right
		} else if( obstacleOnRight ) {
			x -= weight; // go to the left
		} else {
			// no obstacle, already handled above
		}
		y += weight;
		draw();

	}

	void draw() {
		noStroke();
		fill( c );
		rect( x, y, weight, weight );
	}
}


void init_obstacles() {
  int[][] track = new int[w][h];
  int x, y;
  for(int i=0;i<n_obstacles;i++) {
    x = weight * int(random(0,w/weight));
    y = weight * int(random(0,h/weight));
    if( track[x][y] == 1 ) {
      i--;
    }
    else {
      track[x][y] = 1;
      obstacles[i] = new pix(x,y);
    }
  }
}

void draw_obstacles() {
  fill( 1 ); // 0 means it is not an obstacle!

  stroke(128);
  for(int i=0;i<n_obstacles;i++) {
       obstacles[i].draw();
  }
}

// wrapper to represent en draw a point
class pix {
  int x,y;
  pix( int a, int b) { x = a; y = b; }
  void draw() {
    //point(x,y);
    rect( x, y, weight, weight );
  }
}
