import org.openkinect.processing.*;

Kinect kin;
float a = 0;
void setup(){
  size(640,480,P3D);
  kin = new Kinect(this);
  
  kin.initDepth();
  kin.initVideo();
}

void draw(){
  background(0);
  int [] depth = kin.getRawDepth();
  PImage img = kin.getDepthImage();
  //image(img,0,0);
  
  
  pushMatrix();
  translate(width/2,height/2,-2250);
  rotateY(a);
  int skip = 4;
  stroke(255);
  strokeWeight(2);
  beginShape(POINTS);
  for(int x=0 ; x < kin.width;x+=skip){
    for(int y=0 ;y<kin.height ; y+=skip){
     int offset = x+y*kin.width;
     float d = depth[offset];
     
     PVector point = depthToPointCloudPos(x,y,d);
     
     vertex(point.x,point.y,point.z);
    }
  }
  endShape();
  popMatrix();
  
  a += 0.0015;
}

PVector depthToPointCloudPos(int x,int y ,float depthValue){
  PVector point = new PVector();
  point.z = (depthValue);
  point.x = (x- CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z /CameraParams.fy;
  
  return point;
}