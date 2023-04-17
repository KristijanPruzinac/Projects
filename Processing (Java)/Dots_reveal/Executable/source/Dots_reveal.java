import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Dots_reveal extends PApplet {

PImage image;

ArrayList<Pixel> dots;

int reveal_area = 150;

int dots_max_speed = 2;

public void setup(){
  
  
  frameRate(120);
  
  dots = new ArrayList<Pixel>();
  
  image = loadImage("Display.png");
  
  image.loadPixels();
  
  for (int i = 0; i < image.pixels.length; i++){
    if (image.pixels[i] != color(255, 255, 255)){
      dots.add(new Pixel(i % 1920, floor(i / 1920f), new int[]{PApplet.parseInt(red(image.pixels[i])), PApplet.parseInt(green(image.pixels[i])), PApplet.parseInt(blue(image.pixels[i]))}));
    }
  }
}

public void draw(){
  background(255);
  
  for (Pixel dot : dots){
    dot.update();
    dot.show();
  }
}
class Pixel {
  float x;
  float y;
  
  float real_x;
  float real_y;
  
  int target_x;
  int target_y;
  
  float offset_x;
  float offset_y;
  
  boolean in_range = false;
  
  int[] pixel_color;
  
  Pixel(int target_x, int target_y, int[] pixel_color){
    
    this.target_x = target_x;
    this.target_y = target_y;
    
    this.pixel_color = pixel_color;
    
    offset_y = random(-reveal_area, reveal_area);
    
    offset_x = random(-1, 1) * cos(asin(offset_y / reveal_area)) * reveal_area;
    
    y = mouseY + offset_y * 3;
    x = mouseX + offset_x * 3;
    
    real_x = x;
    real_y = y;
  }
  
  public void update(){
    if (sqrt(pow(target_x - mouseX, 2) + pow(target_y - mouseY, 2)) <= reveal_area){
      in_range = true;
      
      x += (target_x - x) / abs(target_x - x) * random(0.5f, dots_max_speed) * (abs(target_x - x) * 0.05f);
      y += (target_y - y) / abs(target_y - y) * random(0.5f, dots_max_speed) * (abs(target_y - y) * 0.05f);
      
      real_x = x;
      real_y = y;
    }
    else {
      in_range = false;
      
      real_x += (mouseX + offset_x - real_x) / abs(mouseX + offset_x - real_x) * random(0.5f, dots_max_speed) * (abs(mouseX + offset_x - real_x) * 0.05f);
      real_y += (mouseY + offset_y - real_y) / abs(mouseY + offset_y - real_y) * random(0.5f, dots_max_speed) * (abs(mouseY + offset_y - real_y) * 0.05f);
      
      x = real_x;
      y = real_y;
    }
  }
  
  public void show(){
    fill(pixel_color[0], pixel_color[1], pixel_color[2]);
    noStroke();
    rect(round(x), round(y), 1, 1);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Dots_reveal" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
