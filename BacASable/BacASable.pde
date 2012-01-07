ArrayList disks;

void setup() {
	width  = screen.width;
	height = screen.height;
	radius = 50;

	size( width, height, P2D);
	background(0);
	frameRate( 15 );
	smooth();

	// HSB makes fading easier since we will
	// just have to change brightness
	colorMode( HSB, 255 );

	disks = new ArrayList();
}

void draw() {
	X = mouseX;
	Y = mouseY;

	// Loop through the disks from older to younger
	for( int i = disks.size() - 1; i >= 0; i--) {
		Disk disk = (Disk) disks.get(i);
		disk.display();
		if( disk.finished() ) {
			//println( "New Size: " + disks.size() );
			disks.remove(i);
		}
	}
}

void mousePressed() {
	// Insert a disk at the beginning of the disk list
	disks.add( 0, new Disk() );
	//println( "New Size: " + disks.size() );
}


class Disk {

	// Properties
	int brightness;
	int hue;

	int x;
	int y;
	int radius;


	// Constructor
	Disk() {
		hue = random(255);
		saturation = 255;
		brightness = 255;

		x = mouseX;
		y = mouseY;
		radius = 50;
	}

	void display() {
		c = color( hue, saturation, brightness );
		fill( c );
		stroke( c );
		ellipse( x, y, radius, radius )

		// TODO find a non linear way to decrease brightness
		brightness -= 4;
		radius += 5;
	}

	void finished() {
		if( brightness < 0 ) {
			return true;
		} else {
			return false;
		}
	}
}
