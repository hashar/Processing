int frame_rate = 24;
int text_size = 18;

// Where we are going to draw text
int y;
// Scrolling speed in pixels
int y_inc = 2;

int i;
String lines[];
int line_ptr = 0;
String shown = "";

void setup() {
  size(720, 480, P2D);

  lines = loadStrings("credits.txt");
  println("Lines in credits..: " + lines.length);
  println("Text size.........: " + text_size + " px");
  println("Credits height....: " + (lines.length * text_size) + " px");

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

  // Every 15 frames or 30 pixels
  int modulo = frameCount % 15;
  if ( modulo == 0 ) {
    if ( line_ptr < lines.length ) {
      shown = shown + "\n" + lines[line_ptr];
      line_ptr++;
    }
  }

  y = y - y_inc;
  pushMatrix();
  translate(0, y);
  text(shown, 0, 0);
  popMatrix();
}
