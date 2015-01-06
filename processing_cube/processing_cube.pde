import processing.serial.*;

Serial port;

float x, y = 0;
float xSum, ySum = 0;
float gyrox, gyroy, gyroz = 0;

void setup() {
  println(Serial.list());
  size(1000, 600, P3D);
  background(0);
  port = new Serial(this, "/dev/tty.usbmodemfa131", 115200);
  

}

void draw() {
  background(0);
  translate(400, 300, 0);
  //x = (mouseX - pmouseX);
  x = gyrox;
  xSum -= x;
  rotateY(radians(xSum / 50.0));
  //y = (mouseY - pmouseY);
  y = gyroy;
  ySum -= y;
  rotateX(radians(ySum / 50.0));
  fill(255,20,0);
  box(200);
  
  if(port.available() > 0) {
    String buffer = port.readString();
    //println(buffer);
    if(trim(buffer) != "") {
      String[] tokens = split(trim(buffer), ';');
      if(tokens.length == 3) {
        if(trim(tokens[0]) != null && tokens[0].length() > 0) {
          try {
            gyrox = Float.parseFloat(tokens[0]);
          } catch(Exception e){
            gyrox = 0.0;
          }
        }
        if(trim(tokens[1]) != "" && tokens[1].length() > 0) {
          try {
            gyroy = Float.parseFloat(tokens[1]);
          } catch(Exception e){
            gyroy = 0.0; 
          }
        }
        if(trim(tokens[2]) != "" && tokens[2].length() > 0) {
          try {
            gyroz = Float.parseFloat(tokens[2]);
          } catch(Exception e){
            gyroz = 0.0;
          }
        }
      }
      //delay(100);
    }
  }
  
  print("Gyro x: " + gyrox);
  print(" Gyro y: " + gyroy);
  println(" Gyro z: " + gyroz);
  
}
