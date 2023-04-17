import net.objecthunter.exp4j.*;
import net.objecthunter.exp4j.shuntingyard.*;
import net.objecthunter.exp4j.tokenizer.*;
import net.objecthunter.exp4j.function.*;
import net.objecthunter.exp4j.operator.*;

boolean show_function = true;
float scalex;
float scaley;

int zoom_restriction = 4;
float lower_restriction = 0.25;

float sensitivity = 1;

int line_length;

Point last_pos;
Point new_pos;

Point offset = new Point(0, 0);

boolean mouse_pressed = false;

boolean function_pressed = false;

boolean shift_pressed = false;

Interface gui = new Interface();

void setup(){
  fullScreen();
  
  textAlign(CENTER, CENTER);
  
  scalex = float(width) / 1920;
  scaley = float(height) / 1080;
  
  line_length = (int) ((float(width) + float(height)) / 2);
  
  gui.update();
}

void mouseWheel(MouseEvent event) {
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

void mousePressed(){
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

void mouseReleased(){
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

void keyPressed(){
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
          gui.update();
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

void keyReleased(){
  if (function_pressed == true){
    if (keyCode == SHIFT){
      shift_pressed = false;
    }
  }
}

void draw(){
  gui.show();
}
