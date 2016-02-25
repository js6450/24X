//libraries
import processing.video.*;
import processing.serial.*;

//serial
Serial port;

//movie array
Movie[] twentyfour = new Movie[2];
int whichMov;

int x1, y1, x2, y2 =0;

void setup(){
  //size(800, 600);
  fullScreen();
  frameRate(25);
  noStroke();
  fill(0);
  
  //serial setup
  port = new Serial(this, Serial.list()[2], 9600);
  port.clear();
  port.bufferUntil('\n');
  
  twentyfour[0] = new Movie(this, "leo.mov");
  twentyfour[1] = new Movie(this, "jiwon.mov");
  
  whichMov = 0;
  
  rect(0, 0, width, height);
  delay(5000);
  
}

void draw(){
  if(whichMov == 0){
    twentyfour[1].volume(0.0);
    twentyfour[0].volume(1.0);
    image(twentyfour[0], 0, 0, width, height);
    twentyfour[0].play();
    x1 = 0;
    y1 = 0;
    x2 = width/2;
    y2 = height;
  }
  else if(whichMov == 1){
    twentyfour[0].volume(0.0);
    twentyfour[1].volume(1.0);
    image(twentyfour[1], 0, 0, width, height);
    twentyfour[1].play();
    x1 = width/2;
    y1 = 0;
    x2 = width;
    y2 = height;
  }
  
  //else if(whichMov == 2){
  //  twentyfour[0].volume(1.0);
  //  twentyfour[1].volume(1.0);
  //  image(twentyfour[0], 0, 0, width, height);
  //  twentyfour[0].play();
  //  image(twentyfour[1], width/2, 0, width, height);
    
  //  pixArr = [10000];
    
  //  for (int i = width/2; i < width; i ++){
  //    for(int j = 0; j < height; j++){
  //      pixArr.append(get(i,j));
  //    }
  //  }
    
  //  for (int i = width; i > width/2; i --){
  //    for(int j = 0; j < height; j++){
  //      //pixArr.append(get(i,j));
  //      point(pixArr(i,j));
  //    }
  //  }
    
  //  loadPixels();
  //  for(int i = width/2; i < width; i++){
  //   for(int j = 0; j < height; j++){
  //    pixels[i] = pixels[i]; 
  //   }
  //  }
  //  updatePixels();
    
  //  twentyfour[1].play();
  //  x1=y1=x2=y2=0;
     
  //}
  
  if(twentyfour[0].time() == twentyfour[0].duration() || twentyfour[1].time() == twentyfour[1].duration()){
    x1 = 0;
    y1 = 0;
    x2 = width;
    y2 = height;
  }

  rect(x1, y1, x2, y2);
}

void movieEvent(Movie m){
  if (m == twentyfour[0]) {
    twentyfour[0].read();
  } else if (m == twentyfour[1]) {
    twentyfour[1].read();
  }
}

void serialEvent(Serial port){
  String inData = port.readStringUntil('\n');
  println(inData);
  if(inData == null || inData.isEmpty()){
   return; 
  }
  inData = trim(inData); 
  if(int(inData) == 2){
    whichMov = 0; 
  }
  else if(int(inData) == 1){
    whichMov = 1;
  }
  //else if(int(inData) == 3){
  // whichMov = 2; 
  //}
}