import gab.opencv.*; //<>//
import processing.video.*;
import java.awt.*;
import org.opencv.core.Mat;

Capture video;
OpenCV opencv;

DrawTrack tracker;
PVector locActMax;
float positionThreshold;
int numberOfMax;
int frameThreshold;
int brightness;
int brightnessThreshold;
  
void setup() {
  // open a new Tracker window
  tracker = new DrawTrack();
  // setup CameraWindow and detection data
  size(640, 480);
  surface.setSize(640,480);
  positionThreshold = 5;
  frameThreshold = 5;
  numberOfMax = 0;
  locActMax = null;
  brightness = -100;
  brightnessThreshold = 155;
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void draw() {
  opencv.loadImage(video);
  opencv.brightness(brightness);
  Mat grey = opencv.getGray();
  image(video,0,0);
    PVector loc = opencv.max();
    double[] pixleValue = grey.get((int)loc.y,(int)loc.x);
    if(pixleValue[0]>=brightnessThreshold){
      if(isNewMax(loc)){
        locActMax = loc;
        numberOfMax=0;
      }
      else{
        numberOfMax++;
      }
      if(numberOfMax==frameThreshold){
        tracker.addPoitToDrawArray(locActMax);
      }
    }
}
void captureEvent(Capture c) {
  c.read();
}
boolean isNewMax(PVector newLoc){
    if(locActMax==null){
      return true;
    }
    boolean answer = true;
    if(newLoc.x <= locActMax.x + positionThreshold && newLoc.x >= locActMax.x - positionThreshold){
       if(newLoc.y <= locActMax.y + positionThreshold && newLoc.y >= locActMax.y - positionThreshold){
         answer = false;
       }
    }
    return answer;  
  }