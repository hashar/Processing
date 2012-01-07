int w = 150, h = 400;

int n_obstacles = 40;
pix[] obstacles = new pix[n_obstacles];

void setup() {
  size(w,h);
  background(0,0,0);
  smooth();
  frameRate(60);

  init_obstacles();
  draw_obstacles();
}

void draw() {

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
  stroke(255);
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
