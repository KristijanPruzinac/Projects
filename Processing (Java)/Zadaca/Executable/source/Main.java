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

public class Main extends PApplet {

PImage plus;
PImage x;

public void setup(){
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
  
}

public void keyPressed(){
  
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

public void mousePressed(){
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
            zadaci.add(new zadatak(add_ime, getDate(PApplet.parseInt(add_month), PApplet.parseInt(add_day)), add_opis));
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
        if (mouseX > 420 + ((i % 4) * 400) - 25 && mouseX < 420 + ((i % 4) * 400) + 50 && mouseY > 180 + (floor((PApplet.parseFloat(i) / 4)) * 400) - 25 + zadaci_offset && mouseY < 180 + (floor((PApplet.parseFloat(i) / 4)) * 400) + 50 + zadaci_offset){   
          zadaci.remove(i);
          
          sortTasks();
          adjustScrollBar();
           
          break;
        }
      }
    }
  }
}

public void mouseReleased(){
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

public void draw(){
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
      
      zadaci_offset = PApplet.parseInt(-(scroll_pos * ceil((PApplet.parseFloat(zadaci.size()) / PApplet.parseFloat(8)))) * 0.8264f);
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

public void stop(){
  zadaci_lista = new String[zadaci.size()];
  
  for (int i = 0; i < zadaci.size(); i++){
    zadaci_lista[i] = zadaci.get(i).ime + ";" + str(zadaci.get(i).datum) + ";" + zadaci.get(i).opis;
  }
  
  saveStrings("Zadaci.txt", zadaci_lista);
  
  exit();
}
public void load(){
  //učitavanje zadataka
  zadaci_lista = loadStrings("Zadaci.txt");
  
  for (String line : zadaci_lista){
    zadaci.add(new zadatak(split(line, ";")[0], PApplet.parseInt(split(line, ";")[1]), split(line, ";")[2]));
  }
}

public void refresh(){
  date = 0;
  
  for (int i = 0; i < month - 1; i++){
    date += month_lengths[i];
  }
  
  date += day;
  
}

public int getDate(int mjesec, int dan){
  
  int return_date = 0;
  
  for (int i = 0; i < mjesec - 1; i++){
    return_date += month_lengths[i];
  }
  
  return_date += dan;
  
  return return_date;
}

public void real_time_refresh(){
  this_sec = second();
  if (this_sec != last_sec){
    
    //refresh datuma
    refresh();
    last_sec = second();
    
    //refresh sata
    hour = hour();
    minute = minute();
    second = second();
    
    //namjesti sat
    if (hour < 10){
      hour_string = "0" + hour;
    }
    else{
      hour_string = str(hour);
    }
    
    if (minute < 10){
      minute_string = "0" + minute;
    }
    else{
      minute_string = str(minute);
    }
    
    if (second < 10){
      second_string = "0" + second;
    }
    else{
      second_string = str(second);
    }
  }
}

//internalne programske funkcije
public void drawTime(){
  //sat
  textSize(40);
  fill(255);
  text(hour_string + ":" + minute_string + ":" + second_string, width - 200, 65);
}

public void drawInterface(){
  //top bar
  noStroke();
  fill(100, 200, 100);
  rect(0, 0, width, 100);
  
  //new button
  noStroke();
  fill(255);
  rect(20, 20, 80, 80);
  image(plus, 15, 15, 85, 85);
  
  //new settings
  
  //ime
  fill(255);
  rect(120, 20, 400, 80);
  textSize(40);
  fill(25);
  if (add_ime.length() != 0){
    text(add_ime, 125, 65);
  }
  else {
    fill(235);
    text("Predmet", 125, 65);
  }
  
  //datum
  fill(255);
  rect(450, 20, 550, 80);
  textSize(40);
  fill(25);
  if (add_day.length() != 0){
    text(add_day, 475, 65);
  }
  else {
    fill(235);
    text("D", 460, 65);
  }
  
  fill(255);
  rect(565, 20, 665, 80);
  textSize(40);
  fill(25);
  if (add_month.length() != 0){
    text(add_month, 590, 65);
  }
  else {
    fill(235);
    text("M", 570, 65);
  }
  
  //opis
  fill(255);
  rect(680, 20, 1510, 80);
  textSize(40);
  fill(25);
  if (add_opis.length() != 0){
    text(add_opis, 685, 65);
  }
  else {
    fill(235);
    text("Opis", 685, 65);
  }
  
  //underline
  if (selected_add_element == 1){
    fill(255);
    rect(120, 85, 400, 90);
  }
  else if (selected_add_element == 2){
    fill(255);
    rect(450, 85, 550, 90);
  }
  else if (selected_add_element == 3){
    fill(255);
    rect(565, 85, 665, 90);
  }
  else if (selected_add_element == 4){
    fill(255);
    rect(680, 85, 790, 90);
  }
  else if (selected_add_element == 5){
    fill(255);
    rect(680, 85, 1510, 90);
  }
}

public void drawBackground(){
  //list background
  noStroke();
  fill(140);
  rect(0, 100, width, height);
}

public void drawScrollBar(){
  noStroke();
  fill(255); 
  rect(width - 25, 100 + scroll_pos, width, 100 + scroll_pos + scroll_length);
}

public void adjustScrollBar(){
  try {
    scroll_length = (height - 100) / ceil((PApplet.parseFloat(zadaci.size()) / PApplet.parseFloat(8))); 
  }
  catch (Exception e){
    
  }
}

public void drawTasks(){
  translate(0, zadaci_offset);
  for (int i = 0; i < zadaci.size(); i++){
    
    fill(200);
    if (zadaci.get(i).datum - date < 0){
      strokeWeight(3);
      stroke(200, 0, 0);
    }
    else {
      noStroke();
    }
    rect(150 + ((i % 4) * 400), 200 + (floor((PApplet.parseFloat(i) / 4)) * 400), 450 + ((i % 4) * 400), 500 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    image(x, 420 + ((i % 4) * 400), 180 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    textSize(32);
    noStroke();
    if (zadaci.get(i).datum - date == 0){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 255 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text("Danas", 149 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date == 1){
      fill(195, 210, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 255 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text("Sutra", 157 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date > 1 && zadaci.get(i).datum - date < 10){
      fill(0, 190, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 265 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text(zadaci.get(i).datum - date + " dana", 148 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date > 9 && zadaci.get(i).datum - date < 100){
      fill(0, 190, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 280 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text(zadaci.get(i).datum - date + " dana", 148 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date > 99){
      fill(0, 190, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 300 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text(zadaci.get(i).datum - date + " dana", 148 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date == -1){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 255 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text("Jučer", 159 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date < -1 && zadaci.get(i).datum - date > -10){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 350 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text("Prije " + str(-(zadaci.get(i).datum - date)) + " dana", 157 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date < -9 && zadaci.get(i).datum - date > -100){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 370 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text("Prije " + str(-(zadaci.get(i).datum - date)) + " dana", 157 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    else {
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((PApplet.parseFloat(i) / 4)) * 400), 390 + ((i % 4) * 400), 210 + (floor((PApplet.parseFloat(i) / 4)) * 400));
      fill(255);
      text("Prije " + str(-(zadaci.get(i).datum - date)) + " dana", 157 + ((i % 4) * 400), 193 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    }
    
    fill(255);
    textSize(40);
    text(zadaci.get(i).ime, 160 + ((i % 4) * 400), 260 + (floor((PApplet.parseFloat(i) / 4)) * 400));
    
    fill(255);
    textSize(20);
    //if (zadaci.get(i).opis.indexOf("#") != -1){
    //  String[] opis_linije = split(zadaci.get(i).opis, "#");
    //  int l = 0;
    //  for (String line : opis_linije){
    //    text(line, 160 + ((i % 4) * 400), 295 + (26 * l) + (floor((float(i) / 4)) * 400));
    //    l++;
    //  }
    //}
    //else {
    //  text(zadaci.get(i).opis, 160 + ((i % 4) * 400), 295 + (floor((float(i) / 4)) * 400));
    //}
    
    text(zadaci.get(i).opis, 160 + ((i % 4) * 400), 295 + (floor((PApplet.parseFloat(i) / 4)) * 400), 430 + ((i % 4) * 400), 480 + (floor((PApplet.parseFloat(i) / 4)) * 400));
  }
  translate(0, -zadaci_offset);
}

public void sortTasks(){
  ArrayList<zadatak> sorted_zadaci = new ArrayList<zadatak>();
  for (int i = -700; i < 700; i++){
    for (zadatak zadatak : zadaci){
      if (zadatak.datum - date == i){
        sorted_zadaci.add(zadatak);
      }
    }
  }
  zadaci = sorted_zadaci;
}
String[] zadaci_lista;

//trenutačni datum
int day = day();
int month = month();
int year = year();

int[] month_lengths = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
int date;


//liste zadataka i oznaka
ArrayList<zadatak> zadaci = new ArrayList<zadatak>();

//pracenje sekundi
int last_sec = 0;
int this_sec = 0;

int hour;
int minute;
int second;

String hour_string;
String minute_string;
String second_string;

//zadaci i scroll
int zadaci_offset = 0;
int scroll_length;
int scroll_pos = 0;

int scroll_start = 0;
int scroll_end = 0;

//window
String window = "Zadaci";

//add bar settings
int selected_add_element = -1;

String add_ime = "";
String add_opis = "";
String add_day = "";
String add_month = "";

//aktivan predmet
int aktivan_element = -1;
class zadatak{
  String ime;
  int datum;
  String opis;
  
  zadatak (String ime, int datum, String opis) {
    this.ime = ime;
    this.datum = datum;
    this.opis = opis;
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
