import themidibus.*;
import javax.sound.midi.*;

MidiBus myBus;
Sequencer sequencer;

float rotAngle = 0;
int oldBackgroundColor = 0;
int actBackgroundColor = 0;
float speeddelta = 0;
int nrOfKeys = 72-48+1;
int[] velocityArray = new int[nrOfKeys];
color[] colorArray = new color[nrOfKeys];
int alphaBubbles = 255;
void setup() {
  //fullScreen();
  frame.setSize(400,400);
  frameRate(60);
    try  {
    // Sequencer initialisieren
    sequencer = MidiSystem.getSequencer();
    // Sequence laden
    selectInput("Select a MIDI file to process:", "loadSeq");
    // Sequencer oeffnen und verbinden
    sequencer.open();
  } 
  catch (Exception e) { 
    // Fehlerbehandlung 
    e.printStackTrace();
  }
  MidiBus.list();
  myBus = new MidiBus(this, 0, 2);
}

void draw(){
  if(actBackgroundColor != oldBackgroundColor){
    background(actBackgroundColor);
    oldBackgroundColor = actBackgroundColor;
  }
  translate(width/2, height/2);
  rotAngle = rotAngle + speeddelta;
  rotate(rotAngle);
  noStroke();
  for( int i = 0; i<nrOfKeys; i++){
    fill(colorArray[i]);
    ellipse(i*(width/(nrOfKeys-1))-(width/2),0,velocityArray[i],velocityArray[i]);
  }
}

void controllerChange(int channel, int number, int value) {
  if (channel == 0){
    switch (number){
      case 71:
        rotAngle = radians(((float)value/127f)*360);
        break;
      case 84:
        actBackgroundColor = (int) (((float)value/127f) * 255);
        break;
      case 74:
        speeddelta = radians(((float)value/127f)*10);
        break;
      case 7:
        alphaBubbles =  255- (int)(((float)value/127f)*255);
    }
  }
}

void noteOn(int channel, int pitch, int velocity) {
    println("pitch:"+velocity);
  myBus.sendNoteOn(channel, pitch, velocity);
  velocityArray[pitch-48] = velocity*2;
  colorArray[pitch-48] = color(random(255),random(255),random(255),alphaBubbles);
}

void noteOff(int channel, int pitch, int velocity) {
  myBus.sendNoteOff(channel, pitch, velocity);
  velocityArray[pitch-48] = 0;
}