class DrawTrack extends PApplet {
  
  ArrayList<PVector> drawArray = new ArrayList<PVector>();
  
  DrawTrack() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(640, 480);
  }

  void setup() {
    background(0);
  }

  void draw() {
    background(0);
    if(drawArray.size()>0){
      stroke(255,255,255);
      for(int i = 0 ; i < drawArray.size();i++){
        ellipse(drawArray.get(i).x,drawArray.get(i).y, 2, 2);
        if(i>0){
          line(drawArray.get(i-1).x,drawArray.get(i-1).y,drawArray.get(i).x,drawArray.get(i).y);
        }
      }
    }
  }

  void mousePressed() {
    drawArray.clear();
  }
  
  void addPoitToDrawArray(PVector newPoint){
    if(newPoint!=null){
      drawArray.add(newPoint);
    }
  }
}