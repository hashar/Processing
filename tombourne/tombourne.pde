// Canvas dimensions in virtual pixels
int cols = 40 ;
int rows = 80 ;

// Size of the virtual pixels
weight = 6;

// Compute canvas size in pixels. Each virtual pixel
// has a 1 pixel border so we need to add that
int w = cols * (weight + 1) + 1 ;
int h = rows * (weight + 1) + 1 ;

int last_y = h - weight - 1;

PGraphics overlay;
overlaydensity = 0.15;

// Snakes which will move around obstacles
ArrayList snakes;
n_snakes = int( w / 30 );

void setup() {
	// Main land, also used for snakes
	size(w,h,P2D);
	background(0);
	colorMode( HSB, 255 );
	frameRate(60);

	// Buffer to draw obstacles
	// Will be added on top of main land
	overlay = createGraphics( w, h, P2D);
	overlay.beginDraw();
	overlay.stroke( 128 );
	// Transparent background or we will erase snakes
	// when overlaying it above the main land
	overlay.background(0,0,0,0);

	// Fill overlay with obstacles
	int i=0;
	int n_rect = 0;
	for (i=i+w+1; i<w*h; i+=weight+1) {
		if( random(1) < overlaydensity ) {
			n_rect++;
				overlay.fill( 64 );
				overlay.rect(
				/* X: */ i%w,
				/* Y: */ floor(i/w),
					weight, weight
				);
		}
		// skip to a new line
		if( (i%w+1+weight) >= w ) {
			i += w * weight + 1;  // +1 which is the border width
		}

	}
	overlay.endDraw();

	snakes = new ArrayList();
	while( n_snakes-- ) {
		snakes.add( new Snake() );
	}
}

void draw() {
	// Overlay which contains obstacles
	image( overlay, 0, 0);

	for( int i = snakes.size() - 1; i>=0; i-- ) {
		Snake snake = (Snake) snakes.get(i);
		snake.fall();
		if( snake.blocked ) {
			snakes.remove(i);
		}
	}
	if( snakes.size() == 0 ) {
		noLoop();
	}
}

class Snake {
	int x;
	int y;
	color c;
	boolean blocked;

	// Constructor
	Snake() {
		step = weight+1;

		x = 1 + 1 + ((int) random( 1 + cols ) ) * step;
		y = 1;
		c = color( random(255), 255, 255 );
		blocked = false;

		draw(); // Show the snake at the top
	}

	void fall() {
		if( blocked || y >= last_y ) {
			return;
		}

		if( get(x,y+step) == color(0) ) {
			y += step;
			draw();
			return;
		}

		obstacleOnLeft  = ( get(x-step,y) != color(0) );
		obstacleOnRight = ( get(x+step,y) != color(0) );

		if( !obstacleOnLeft && !obstacleOnRight ) {
			// choose randomly between left and right
			if( 1 == int( random(2) ) ) {
				x += step;
			} else {
				x -= step;
			}
		} else if( obstacleOnLeft && obstacleOnRight ) {
			blocked = true;
			return;
		} else if( obstacleOnLeft ) {
			x += step; // go to the right
		} else if( obstacleOnRight ) {
			x -= step; // go to the left
		} else {
			// no obstacle, already handled above
		}
		draw();

	}

	void draw() {
		noStroke();
		fill( c );
		rect( x, y, weight, weight );
	}
}

