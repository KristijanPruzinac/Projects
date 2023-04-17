import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import net.objecthunter.exp4j.*; 
import net.objecthunter.exp4j.shuntingyard.*; 
import net.objecthunter.exp4j.tokenizer.*; 
import net.objecthunter.exp4j.function.*; 
import net.objecthunter.exp4j.operator.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Function extends PApplet {







boolean show_function = true;
float scalex;
float scaley;

int zoom_restriction = 4;
float lower_restriction = 0.25f;

float sensitivity = 1;

int line_length;

Point last_pos;
Point new_pos;

Point offset = new Point(0, 0);

boolean mouse_pressed = false;

boolean function_pressed = false;

boolean shift_pressed = false;

Interface gui = new Interface();

public void setup(){
  
  
  textAlign(CENTER, CENTER);
  
  scalex = PApplet.parseFloat(width) / 1920;
  scaley = PApplet.parseFloat(height) / 1080;
  
  line_length = (int) ((PApplet.parseFloat(width) + PApplet.parseFloat(height)) / 2);
  
  gui.update();
}

public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  e = -e;
  
  if (e > 0){
    if (gui.zoom * 2 <= zoom_restriction){
      gui.zoom *= 2;
    }
  }
  else if (e < 0){
    if (gui.zoom / 2 >= lower_restriction){
      gui.zoom /= 2;
    }
  }
}

public void mousePressed(){
  if (mouseX > scaleX(1800 - (gui.function.length() + 5) * 19.5f) && mouseX < scaleX(1800) && mouseY > scaleY(1000 - 40) && mouseY < scaleY(1000 + 40)){
    //if (function_pressed == true){
      
    //  for (int count = gui.function.length() - 1; count > 0; count--){
    //    if (scaleX(1800) - scaleX(gui.letter_distances[count]) <= mouseX){
    //      gui.pointer_index = count;
    //      break;
    //    }
    //  }
      
    //  if (gui.pointer_index < 0){
    //    gui.pointer_index = 0;
    //  }
    //  else if (gui.pointer_index > gui.function.length()){
    //    gui.pointer_index = gui.function.length();
    //  }
    //}
    //else {
      function_pressed = true;
  }
  else {
    function_pressed = false;
    
    mouse_pressed = true;
    last_pos = new Point(mouseX, mouseY);
  }
}

public void mouseReleased(){
  if (function_pressed == true){
    
  }
  else {
    mouse_pressed = false;
    new_pos = new Point(mouseX, mouseY);
    
    offset.x += scaleX(new_pos.x - last_pos.x) * sensitivity;
    offset.y += scaleY(new_pos.y - last_pos.y) * sensitivity;
    
    last_pos = new_pos;
  }
}

public void keyPressed(){
  if (function_pressed == true){
    if (keyCode == SHIFT){
      shift_pressed = true;
    }
    else if (keyCode == BACKSPACE){
      if (gui.function.length() > 0){
        if (gui.pointer_index == 0){
          //pass
        }
        else if (gui.pointer_index == gui.function.length()){
          gui.function = gui.function.substring(0, gui.function.length() - 1);
          gui.update();
        }
        else {
          gui.function = removeLetter(gui.function, gui.pointer_index - 1);
          gui.pointer_index--;
        }
        
        if (gui.pointer_index > gui.function.length()){
          gui.pointer_index = gui.function.length();
        }
        else if (gui.pointer_index < 0){
          gui.pointer_index = 0;
        }
      }
    }
    else if (keyCode == LEFT){
      if (gui.pointer_index > 0){
        gui.pointer_index --;
        gui.pointer_count = 0;
      }
    }
    else if (keyCode == RIGHT){
      if (gui.pointer_index < gui.function.length()){
        gui.pointer_index++;
        gui.pointer_count = 0;
      }
    }
    else if (keyCode != CONTROL && keyCode != TAB && keyCode != ENTER && keyCode != ALT && keyCode != UP && keyCode != DOWN){
      if (gui.pointer_index == gui.function.length()){
        gui.function += key;
        gui.pointer_index++;
        gui.update();
      }
      else{
        gui.function = insertLetter(gui.function, str(key), gui.pointer_index);
        gui.pointer_index++;
        gui.update();
      }
    }
  }
}

public void keyReleased(){
  if (function_pressed == true){
    if (keyCode == SHIFT){
      shift_pressed = false;
    }
  }
}

public void draw(){
  gui.show();
}
class Interface {
  String function = "";
  
  float zoom = 1;
  
  int value_count = 8;
  
  float step = 0.25f;
  
  int pointer_count = 0;
  
  int pointer_index = 0;
  
  float[] letter_distances;
  
  Point[] points = new Point[PApplet.parseInt((float) (value_count * 2) / step)];
  
  public void update(){
    points = new Point[PApplet.parseInt((float) (value_count * 2) / step) + 1];
    
    try {
      int index = 0;
      for (float x = -value_count; x <= value_count; x += step){
        points[index] = new Point(x, result(x, function));
        index++;
      }
    } catch (Exception e){
      
    }
    
    letter_distances = new float[function.length()];
    
    //for (int count = 0; count < function.length(); count++){
    //  //try {
    //  letter_distances[count] = textWidth(function.substring(count, function.length()));
    //  //} catch (Exception e){
        
    //  //}
    //}
  }
  
  public void show(){
    background(255);
    
    //update pointer
    pointer_count++;
    
    if (pointer_count > 60){
      pointer_count = 0;
    }
    
    //if (pointer_index < 0){
    //  pointer_index = 0;
    //}
    //else if (pointer_index > function.length() - 1){
    //  pointer_index = function.length() - 1;
    //}
    
    //Function indicator
    if (show_function == true){
      textAlign(RIGHT, CENTER);
      textSize(scaleY(40));
      
      fill(100, 180, 100);
      
      text("f(x)=" + function, scaleX(1800), scaleY(1000));
      
      noFill();
      stroke(100, 180, 100);
      if (function_pressed == true){
        line(scaleX(1800) - textWidth("f(x)=" + function), scaleY(1030), scaleX(1800), scaleY(1030));
        
        if (pointer_count < 30){
          line(scaleX(1800 - textWidth(function.substring(pointer_index, function.length()))), scaleY(980), scaleX(1800 - textWidth(function.substring(pointer_index, function.length()))), scaleY(1020));
        }
      }
    }
    
    //Zoom indicator
    fill(0);
    noStroke();
    text(str(zoom) + "X", scaleX(1800), scaleY(900));
    
    //update move
    if (mouse_pressed == true){
      new_pos = new Point(mouseX, mouseY);
      
      offset.x += scaleX((int) (new_pos.x - last_pos.x)) * sensitivity;
      offset.y += scaleY((int) (new_pos.y - last_pos.y)) * sensitivity;
      
      last_pos = new_pos;
    }
    
    //translate
    translate((int) offset.x, (int) offset.y);
    
    //show coordinate lines
    noFill();
    strokeWeight(2);
    stroke(0);
    
    //show grid
    noFill();
    stroke(150);
    strokeWeight(1);
    
    //horizontal lines
    for (int count = 0; count <= value_count * 2 * zoom; count++){
      line((width / 2) - (float) (line_length / 4) * zoom, (height / 2) - (float) (line_length / 4) * zoom + (float) (line_length / 4) / (value_count * zoom) * count * zoom, (width / 2) + (float) (line_length / 4) * zoom, (height / 2) - (float) (line_length / 4) * zoom + (float) (line_length / 4) / (value_count * zoom) * count * zoom);
    }
    
    //vertical lines
    for (int count = 0; count <= value_count * 2 * zoom; count++){
      line((width / 2) - (float) (line_length / 4) * zoom + (float) (line_length / 4) / (value_count * zoom) * count * zoom, (height / 2) - (float) (line_length / 4) * zoom, (width / 2) - (float) (line_length / 4) * zoom + (float) (line_length / 4) / (value_count * zoom) * count * zoom, (height / 2) + (float) (line_length / 4) * zoom);
    }
    
    //x axis
    line((width / 2) - (line_length / 4) * zoom, height / 2, (width / 2) + (line_length / 4) * zoom, height / 2);
    
    //y axis
    line(width / 2, (height / 2) - (line_length / 4) * zoom, width / 2, (height / 2) + (line_length / 4) * zoom);
    
    //show points
    noStroke();
    fill(0);
    textSize(scaleY(15));
    
    textAlign(CENTER, CENTER);
    for (int count = 1; count < PApplet.parseFloat(value_count) * zoom + 1; count++){
      ellipse((width / 2) + ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2, scaleY(8), scaleY(8));
      
      text(rz(PApplet.parseFloat(count) / zoom), (width / 2) + ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2 + scaleY(10));
    }
    for (int count = 1; count < PApplet.parseFloat(value_count) * zoom + 1; count++){
      ellipse((width / 2) - ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2, scaleY(8), scaleY(8));
      
      text("-" + rz(PApplet.parseFloat(count) / zoom), (width / 2) - ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2 + scaleY(10));
    }
    
    textAlign(RIGHT, CENTER);
    
    for (int count = 1; count < PApplet.parseFloat(value_count) * zoom + 1; count++){
      ellipse(width / 2, (height / 2) - ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count, scaleY(8), scaleY(8));
      
      text(rz(PApplet.parseFloat(count) / zoom), width / 2 - scaleX(10), (height / 2) - ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count);
    }
    for (int count = 1; count < PApplet.parseFloat(value_count) * zoom + 1; count++){
      ellipse(width / 2, (height / 2) + ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count, scaleY(8), scaleY(8));
      
      text("-" + rz(PApplet.parseFloat(count) / zoom), width / 2 - scaleX(10), (height / 2) + ((PApplet.parseFloat(line_length) / 4) / (value_count * zoom)) * zoom * count);
    }
    
    //show Function
    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    
    try {
      for (int count = 0; count < points.length; count++){
        if (count > PApplet.parseInt(points.length) / 2){
          if ((float) scaleY(points[count + 1].y) * ((float) (line_length / 4) / (float) value_count) > (float) (line_length / 4) || (float) scaleY(points[count + 1].y) * ((float) (line_length / 4) / (float) value_count) < (float) -(line_length / 4)){
            break;
          }
        }
        if ((float) scaleY(points[count].y) * ((float) (line_length / 4) / (float) value_count) >= -(float) (line_length / 4) && (float) scaleY(points[count].y) * ((float) (line_length / 4) / (float) value_count) <= (float) (line_length / 4)){
          line(PApplet.parseInt(width / 2) + (float) scaleX(points[count].x) * ((float) (line_length / 4) / (float) value_count) * (float) zoom, PApplet.parseInt(height / 2) - (float) scaleY(points[count].y) * ((float) (line_length / 4) / (float) value_count) * (float) zoom, PApplet.parseInt(width / 2) + (float) scaleX(points[count + 1].x) * ((float) (line_length / 4) / (float) value_count) * (float) zoom, (height / 2) - (float) scaleY(points[count + 1].y) * ((float) (line_length / 4) / (float) value_count) * (float) zoom);
        }
      }
    } catch (Exception e){
      
    }
  }
}
class Layer {
  int layer_index;
  
  String formula;
  
  String value;
  
  Layer(int layer_index, String formula){
    this.layer_index = layer_index;
    this.formula = formula;
  }
}
class Point{
  double x;
  double y;
  
  Point(double x, double y){
    this.x = x;
    this.y = y;
  }
}
public String rz(float number){
  String return_val;
  
  if (number % 1 == 0){
    return_val = str(PApplet.parseInt(number));
  }
  else if (number % 0.5f == 0){
    return_val = str(PApplet.parseInt(number * 10) / PApplet.parseFloat(10));
  }
  else {
    return_val = str(PApplet.parseInt(number * 100) / PApplet.parseFloat(100));
  }
  
  return return_val;
}

public double result(float x, String function){
  double return_val = 0;
  
  Expression e = new ExpressionBuilder(function)
                .variables("x")
                .build()
                .setVariable("x", x);
  
  return_val = e.evaluate();
  
  return return_val;
}
public float scaleX(double value){
  return (float) value * scalex;
}

public float scaleY(double value){
  return (float) value * scaley;
}
public String insertLetter(String text, String letter, int index){
  char[] chars = text.toCharArray();
  String result = "";
  
  for (int count = 0; count < chars.length + 1; count++){
    if (count == index){
      result += letter;
    }
    
    try{
      result += chars[count];
    } catch (Exception e){
      
    }
  }
  
  return result;
}

public String removeLetter(String text, int index){
  char[] chars = text.toCharArray();
  String result = "";
  
  for (int count = 0; count < chars.length + 1; count++){
    if (count == index){
      continue;
    }
    else{
      try{
        result += chars[count];
      } catch (Exception e){
        
      }
    }
  }
  
  return result;
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Function" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
