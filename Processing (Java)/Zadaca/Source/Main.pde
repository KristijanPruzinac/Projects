PImage plus;
PImage x;

void setup(){
  //load images
  plus = loadImage("plus.png");
  x = loadImage("X.png");
  
  //settings
  imageMode(CORNERS);
  rectMode(CORNERS);
  frameRate(60);
  
  //početak
  load();
  //sort tasks
  sortTasks();
  adjustScrollBar();
  
  //prepoznavanje prijestupne godine
  if (year % 100 == 0){
    if (year % 400 == 0){
      month_lengths[1] = 29;
    }
  }
  else if (year % 4 == 0){
    month_lengths[1] = 29;
  }
  
  //usklađivanje vremena
  refresh();
  
  //veličina prozora
  fullScreen();
}

void keyPressed(){
  
  if (keyCode == ESC){
    stop();
  }
  
  if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != TAB && keyCode != ENTER && keyCode != LEFT && keyCode != RIGHT && keyCode != UP && keyCode != DOWN)
    if (selected_add_element == 1){
      if (keyCode == BACKSPACE){
        if (add_ime.length() > 0){
          add_ime = add_ime.substring(0, add_ime.length() - 1);
        }
      }
      else{
        if (add_ime.length() < 11){
          add_ime += key;
        }
      }
    }
    else if (selected_add_element == 2){
      if (keyCode == BACKSPACE){
        if (add_day.length() > 0){
          add_day = add_day.substring(0, add_day.length() - 1);
        }
      }
      else{
        if (add_day.length() < 2){
          add_day += key;
        }
      }
    }
    else if (selected_add_element == 3){
      if (keyCode == BACKSPACE){
        if (add_month.length() > 0){
          add_month = add_month.substring(0, add_month.length() - 1);
        }
      }
      else{
        if (add_month.length() < 2){
          add_month += key;
        }
    }
  }
  else if (selected_add_element == 5){
    if (keyCode == BACKSPACE){
      if (add_opis.length() > 0){
        add_opis = add_opis.substring(0, add_opis.length() - 1);
      }
    }
    else{
      if (add_opis.length() < 38){
        add_opis += key;
      }
    }
  }
}

void mousePressed(){
  if (window == "Zadaci"){
    if (mouseButton == LEFT){
      //scroll
      if (mouseX > width - 25 && mouseY > 100 + scroll_pos && mouseY < 100 + scroll_pos + scroll_length){
        scroll_start = mouseY - scroll_pos;
      }
      
      //select bar
      if (mouseX > 120 && mouseY > 20 && mouseX < 400 && mouseY < 80){
        selected_add_element = 1;
      }
      else if (mouseX > 450 && mouseY > 20 && mouseX < 550 && mouseY < 80){
        selected_add_element = 2;
      }
      else if (mouseX > 565 && mouseY > 20 && mouseX < 665 && mouseY < 80){
        selected_add_element = 3;
      }
      else if (mouseX > 680 && mouseY > 20 && mouseX < 1510 && mouseY < 80){
        selected_add_element = 5;
      }
      
      //add button
      else if (mouseX > 20 && mouseX < 80 && mouseY > 20 && mouseY < 80){
        if (add_ime.length() != 0 && add_day.length() != 0 && add_month.length() != 0 && add_opis.length() != 0){
          try {
            zadaci.add(new zadatak(add_ime, getDate(int(add_month), int(add_day)), add_opis));
          }
          catch (Exception e) {
            
          }
          sortTasks();
          adjustScrollBar();
        }
      }
      
      else {
        selected_add_element = -1;
      }
      
      //remove tasks button
      for (int i = 0; i < zadaci.size(); i++){
        if (mouseX > 420 + ((i % 4) * 400) - 25 && mouseX < 420 + ((i % 4) * 400) + 50 && mouseY > 180 + (floor((float(i) / 4)) * 400) - 25 + zadaci_offset && mouseY < 180 + (floor((float(i) / 4)) * 400) + 50 + zadaci_offset){   
          zadaci.remove(i);
          
          sortTasks();
          adjustScrollBar();
           
          break;
        }
      }
    }
  }
}

void mouseReleased(){
  if (window == "Zadaci"){
    if (mouseButton == LEFT){
      //scroll
      scroll_end = mouseY;
      
      //zadaci_offset += scroll_end - scroll_start;
      
      scroll_start = 0;
      scroll_end = 0;
    }
  }
}

void draw(){
  background(150);
  
  if (window == "Zadaci"){
    
    //scroll
    if (scroll_start != 0){
      scroll_pos = mouseY - scroll_start;
      
      if (scroll_pos + scroll_length > height - 100){
        scroll_pos = height - 100 - scroll_length;
      }
      
      if (scroll_pos < 0){
        scroll_pos = 0;
      }
      
      zadaci_offset = int(-(scroll_pos * ceil((float(zadaci.size()) / float(8)))) * 0.8264);
    }
    
    //pracenje sekundi u realnom vremenu
    real_time_refresh();
    
    //interface
    drawBackground();
    drawTasks();
    drawInterface();
    drawTime();
    drawScrollBar();
  }
}

void stop(){
  zadaci_lista = new String[zadaci.size()];
  
  for (int i = 0; i < zadaci.size(); i++){
    zadaci_lista[i] = zadaci.get(i).ime + ";" + str(zadaci.get(i).datum) + ";" + zadaci.get(i).opis;
  }
  
  saveStrings("Zadaci.txt", zadaci_lista);
  
  exit();
}
