import org.openkinect.processing.*;

Kinect kin;

void setup(){
  size(640,480);
  kin = new Kinect(this);
  
  kin.initDepth();
  kin.initVideo();
}

void draw(){
  background(0);
  PImage img = kin.getDepthImage();
  image(img,0,0);
  int skip = 20;
  for(int x=0 ;x<img.width;x+=skip){
    for(int y=0 ;y<img.height ; y+=skip){
     int index = x+y*img.width;
     float b = brightness(img.pixels[index]);
     fill(b);
     rect(x,y,skip,skip);
    }
  }
  
}