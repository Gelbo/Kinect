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
  
  minThreshold = map(mouseX,0,width,0,2048);
  maxThreshold = map(mouseY,0,height,0,2048);
  
  int [] depth = kin.getRawDepth();
  
  for(int x=0 ; x < kin.width;x++){
    for(int y=0 ;y<kin.height ; y++){
     int offset = x+y*kin.width;
     float d = depth[offset];
     if(d>minThreshold && d<maxThreshold){
       img.pixels[offset] = color(250,0,150);  
     }else{
       img.pixels[offset] = color(0);
     }
    }
  }
  img.updatePixels();
  image(img,0,0);
  
  fill(255);
  textSize(32);
  text(minThreshold +" "+maxThreshold,64,100);
}