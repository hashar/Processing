int w = 150, h = 600;

int n_obstacles = w * h / 5;
pix[] obstacles = new pix[n_obstacles];

ArrayList snakes;

void setup() {
  size(w,h);
  background(0,0,0);
  colorMode( HSB, 255 );
  smooth();
  frameRate(60);

  init_obstacles();
  draw_obstacles();

  snakes = new ArrayList();
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
  snakes.add( new Snake() );
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


		if( get(x,y+1) == color(0) ) {
			y++;
			draw();
			return;
		}

		obstacleOnLeft  = ( get(x-1,y) != color(0) );
		obstacleOnRight = ( get(x+1,y) != color(0) );

		if( !obstacleOnLeft && !obstacleOnRight ) {
			// choose randomly between left and right
			if( 1 == int( random(2) ) ) {
				x++;
			} else {
				x--;
			}
		} else if( obstacleOnLeft ) {
			x++; // go to the right
		} else if( obstacleOnRight ) {
			x--; // go to the left
		} else {
			println( "We are blocked!!" );
			blocked = true;
			return;
		}
		y++;
		draw();

	}

	void draw() {
		stroke( c );
		point(x,y);
	}
}


void init_obstacles() {
  int[][] track = new int[w][h];
  int x, y;
  for(int i=0;i<n_obstacles;i++) {
    x = int(random(0,w));
    y = int(random(0,h));
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
  stroke(128);
  for(int i=0;i<n_obstacles;i++) {
       obstacles[i].draw();
  }
}

// wrapper to represent en draw a point
class pix {
  int x,y;
  pix( int a, int b) { x = a; y = b; }
  void draw() { point(x,y); }
}
