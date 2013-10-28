int frame_rate = 24;
int text_size = 18;

// Where we are going to draw text
int y;
// Scrolling speed in pixels
int y_inc = 4;

int i;
String credits;
int line_ptr = 0;
String shown = "";

void setup() {
  size(720, 480, P2D);

  credits = join(loadStrings("credits.txt"), "\n");

  background(0, 0, 0);
  fill(255, 255, 255);

  smooth();
  frameRate(frame_rate);
  textFont(createFont("Menlo", text_size), text_size);

  // Start drawing at the bottom (and out) of the screen
  y = height;
}

void draw() {
  // clear screen
  background(0, 0, 0);

  y = y - y_inc;
  pushMatrix();
  translate(0, y);
  textAlign(CENTER);
  text(credits, width/2, 0);
  popMatrix();
  
  //saveFrame();
  if(frameCount == 650 ) {
   noLoop();
  }
}
