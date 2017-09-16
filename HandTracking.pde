import org.openkinect.processing.*;

Kinect kin;
PImage img;
float maxThreshold,minThreshold;
void setup(){
  size(640,480,P3D);
  kin = new Kinect(this);
  
  kin.initDepth();
  kin.initVideo();
  img = createImage(kin.width,kin.height,RGB);
}

void draw(){
  background(0);
  img.loadPixels();
  
  minThreshold = 500;
  maxThreshold = 700;
  
  int [] depth = kin.getRawDepth();
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  for(int x=0 ; x < kin.width;x++){
    for(int y=0 ;y<kin.height ; y++){
     int offset = x+y*kin.width;
     float d = depth[offset];
     if(d>minThreshold && d<maxThreshold){
       img.pixels[offset] = color(250,0,150);  
       sumX += x;
       sumY += y;
       totalPixels++;
     }else{
       img.pixels[offset] = color(0);
     }
    }
  }
  img.updatePixels();
  image(img,0,0);
  
  float avgX = sumX/totalPixels;
  float avgY = sumY/totalPixels;
  
  fill(150,0,255);
  ellipse(avgX,avgY,60,60);
  
  fill(255);
  textSize(32);
  text(minThreshold +" "+maxThreshold,64,100);
}