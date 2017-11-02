import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer groove;


int columns,rows;
int scale = 10;
int w = 1200, h = 900;


float fly;
float[][] terrain;
void setup(){
    size(600,600,P3D);
    minim = new Minim(this);
    groove = minim.loadFile("groove.mp3");
    columns = w/scale;
    rows = h/scale;
    terrain = new float[columns][rows];
    
   groove.play();
   
}

void draw(){
    fly -= 0.08;
   float yoff = fly;
    for (int y = 0; y < rows; y++){
      float xoff = 0;
      for (int x = 0; x < columns; x++){
        terrain[x][y] = map(noise(xoff,yoff),0,1,-100,100);
        
        xoff += 0.2;
      }
      yoff += 0.2;
    }
  
  background(0);
  stroke(255);
  strokeWeight(0.5);
  noFill();
  translate(width/2,height/2 - 25);
  rotateX(PI/3);
  translate(-w/2,-h/2);
  
  for (int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < columns; x++){
      
      //random terrain algorithm
      vertex(x*scale,y*scale,terrain[x][y]);
      vertex(x*scale,(y+1)*scale,terrain[x][y+1]);
    }
    endShape();
  }
  
  showwave();
}

void showwave(){
  strokeWeight(1);
  for(int i = 0; i < groove.bufferSize() - 1; i++){
        float x1 = map( i, 0, groove.bufferSize(), 0, w );
        float x2 = map( i+1, 0, groove.bufferSize(), 0, w );
        line( x1, 50 ,150+ groove.left.get(i)*50, x2, 50 ,150+ groove.left.get(i+1)*50 );
       }

}