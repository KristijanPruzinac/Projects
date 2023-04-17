import com.hamoid.*;
import java.util.*;

float scalex;
float scaley;

//sprites
ArrayList<Sprite> sprites = new ArrayList<Sprite>();

ArrayList<Dropdown_menu> dropdown_menus = new ArrayList<Dropdown_menu>();

int image_file_num = 0;

int id_assign = 0;

//images
PImage recent_image; //open_image tab component
boolean fileOpened = false;

PImage check_mark;
PImage settings_icon;
PImage plus;
PImage minus;

PImage green_plus;
PImage red_minus;

PImage play;
PImage stop;

PImage snap_unpressed;
PImage snap_pressed;

PImage eye_closed;
PImage eye_opened;

PImage updates_on;
PImage updates_off;

PImage background_icon;
PImage rectangle;
PImage ellipse;
PImage no_icon;

PImage linear;
PImage ease_out;
PImage ease_in;
PImage integer;

PImage export;

PImage rename;

//keys
Boolean shift_clicked = false;
Boolean ctrl_pressed = false;
Boolean scrollbar_moving = false;
boolean playhead_moving = false;
boolean sprite_window_scrollbar_moving = false;

int sprite_window_scrollbar_moving_offset = 0;

//video object;
VideoExport videoExport;


//frame
int fps = 60;
int frame = 1;

//settings
Boolean video_quality_clicked = false;
Boolean framerate_clicked = false;

String cursor = "ARROW";

String[] floats;

boolean sprite_settings_typing = false;
int sprite_settings_index;

boolean sprite_settings_selected = false;
int sprite_settings_selected_index = 0;

//record
Boolean recording = false;

//position reference points
ArrayList<Point> reference_points;

//objects
Interface interface1 = new Interface();

//background
int[] background_color = {54, 57, 64};

//MousePressed
int mousePressedX = 0;
int mousePressedY = 0;
boolean mouse_pressed_wait = false;

//Snap pressed
boolean is_snap_pressed = true;

//Sprite dragging
boolean sprite_dragging = false;

//Sprite rotating
boolean sprite_rotating = false;

//Sprite mode 0 = show one, 1 = show all
boolean sprite_mode = false;

boolean instant_update = false;

//Don't update current positions next time (Instant update)
boolean update_penalty = false;

//Frame skip
float frame_decimal = 0;

Sprite copied_sprite;

void setup() {
  fullScreen();
  
  frameRate(60);
  
  //init reference_points
  //reference_points = new ArrayList<Point>();
  
  //Setup
  //dropdown_menus.add(new Dropdown_menu("New sprite", 1580, 825, 200, 50, new String[]{"Image", "Rectangle", "Ellipse"}));
  dropdown_menus.add(new Dropdown_menu("New sprite", 1580, 825, 200, 50, new String[]{"Image"}));
  sprites.add(new Sprite("Background"));
  sprites.get(0).name = "Background";
  
  floats = new String[7];
  
  //load images
  check_mark = loadImage("Icons/Checkmark.png");
  settings_icon = loadImage("Icons/Configure.png");
  plus = loadImage("Icons/plus.png");
  minus = loadImage("Icons/minus.png");
  
  green_plus = loadImage("Icons/green_plus.png");
  red_minus = loadImage("Icons/red_minus.png");
  
  play = loadImage("Icons/Play.png");
  stop = loadImage("Icons/Stop.png");
  
  export = loadImage("Icons/Export.png");
  
  rename = loadImage("Icons/Rename.png");
  
  snap_unpressed = loadImage("Icons/Snap_unpressed.png");
  snap_pressed = loadImage("Icons/Snap_pressed.png");
  
  eye_closed = loadImage("Icons/eye_closed.png");
  eye_opened = loadImage("Icons/eye_opened.png");
  
  updates_on = loadImage("Icons/Updates_on.png");
  updates_off = loadImage("Icons/Updates_off.png");
  
  //Icons
  background_icon = loadImage("Icons/Background_icon.png");
  rectangle = loadImage("Icons/Rectangle.png");
  ellipse = loadImage("Icons/Ellipse.png");
  no_icon = loadImage("Icons/No_icon.png");
  
  linear = loadImage("Icons/linear.png");
  ease_out = loadImage("Icons/ease_out.png");
  ease_in = loadImage("Icons/ease_in.png");
  integer = loadImage("Icons/integer.png");
  
  //load video object;
  videoExport = new VideoExport(this, "Animation/animation.mp4");
  
  rectMode(CORNER);
  noStroke();
  imageMode(CENTER);
  
  textAlign(LEFT, CENTER);
  
  scalex = width / 1920;
  scaley = height / 1080;
  
  //scale(scalex, scaley);
}

float roundT(float number, float decimal) {
    return (float) (round(number*pow(10, decimal))) / pow(10, decimal);
} 

void mousePressed(){
  mousePressedX = mouseX;
  mousePressedY = mouseY;
  
  mouse_pressed_wait = true;
}

void mousePressedEvent(){
  if (interface1.mode == "Animation_Editor"){
    //left mouse button
    if (mouseButton == LEFT){
      
      if (sprite_settings_typing == true){
        
        sprite_settings_typing = false;
        
        if (sprites.get(interface1.sprite_selected_index).type == "Image") {
          
          if (sprite_settings_index == 4){
            if (floats[sprite_settings_index] != ""){
              try {
                interface1.current_rotation = float(floats[sprite_settings_index]);
              }
              catch (Exception e){
              
              }
              
              if (interface1.current_rotation > 360){
                interface1.current_rotation = 360;
              }
              else if (interface1.current_rotation < 0){
                interface1.current_rotation = 0;
              }
            }
          }
          else if (sprite_settings_index == 5){
            if (floats[sprite_settings_index] != ""){
              try {
                interface1.current_visibility = float(floats[sprite_settings_index]);
              }
              catch (Exception e){
              
              }
              
              if (interface1.current_visibility > 1){
                interface1.current_visibility = 1;
              }
              else if (interface1.current_visibility < 0){
                interface1.current_visibility = 0;
              }
            }
          }
        }
        
        updateTextboxWidths();
      }
      
      //Update sprite window scrollbar
      
      if (isMouseOn(interface1.sprite_window_scrollbar_x + 1, interface1.sprite_window_scrollbar_y + interface1.sprite_window_offset_height, interface1.sprite_window_scrollbar_width - 2, interface1.sprite_window_scrollbar_length, "CORNER")){
        sprite_window_scrollbar_moving = true;
        
        sprite_window_scrollbar_moving_offset = (int) (mouseY - interface1.sprite_window_offset_height - interface1.sprite_window_scrollbar_length / 2f);
      }
      
      //reset rotation and visibility strings
      
      //if (sprites.get(interface1.sprite_selected_index).type == "Image"){
      //  floats = new String[7];
      //}
      
      if (sprites.get(interface1.sprite_selected_index).type == "Image"){
        if (sprite_settings_index == 4){
          floats[sprite_settings_index] = str(interface1.current_rotation);
        }
        else {
          floats[sprite_settings_index] = str(interface1.current_visibility);
        }
      }
      
      for (Dropdown_menu menu : dropdown_menus){
        menu.update(mouseX, mouseY);
      }
      
      if (interface1.sprite_selected == true && isMouseOn(interface1.sprite_settings_x, interface1.sprite_settings_y, interface1.sprite_settings_width, interface1.sprite_settings_height, "CORNER")){
        boolean mouseIsOn = false;
        
        if (sprites.get(interface1.sprite_selected_index).type == "Image"){
                
          for (int count = 0; count < interface1.textbox_offset.length; count++){
            if (isMouseOn((int) (interface1.sprite_settings_x + interface1.textbox_offset[count] - interface1.textbox_width_offset), (int) (interface1.sprite_settings_y + (count + 0.5f) * interface1.sprite_settings_element_height - interface1.sprite_settings_element_height / 4 + 3), interface1.textbox_width[count], (int) (interface1.sprite_settings_element_height / 2), "CORNER")){
              
              sprite_settings_typing = true;
              sprite_settings_index = count;
              
              mouseIsOn = true;
              
              break;
            }
          }
        }
        
        if (sprites.get(interface1.sprite_selected_index).type == "Background"){
          if (isMouseOn((int) (interface1.sprite_settings_x + interface1.textbox_offset[0] - interface1.textbox_width_offset), (int) (interface1.sprite_settings_y + (0.5f) * interface1.sprite_settings_element_height - interface1.sprite_settings_element_height / 4 + 3), (int) (interface1.textbox_width[0]), (int) (interface1.sprite_settings_element_height / 2), "CORNER")){
            mouseIsOn = true;
            sprite_settings_index = 0;
          }
          else if (isMouseOn((int) (interface1.sprite_settings_x + interface1.textbox_offset[0] - interface1.textbox_width_offset + interface1.textbox_width[0] + 10), (int) (interface1.sprite_settings_y + (0.5f) * interface1.sprite_settings_element_height - interface1.sprite_settings_element_height / 4 + 3), (int) (interface1.textbox_width[1]), (int) (interface1.sprite_settings_element_height / 2), "CORNER")){
            mouseIsOn = true;
            sprite_settings_index = 1;
          }
          else if (isMouseOn((int) (interface1.sprite_settings_x + interface1.textbox_offset[0] - interface1.textbox_width_offset + interface1.textbox_width[0] + interface1.textbox_width[1] + 20), (int) (interface1.sprite_settings_y + (0.5f) * interface1.sprite_settings_element_height - interface1.sprite_settings_element_height / 4 + 3), (int) (interface1.textbox_width[2]), (int) (interface1.sprite_settings_element_height / 2), "CORNER")){
            mouseIsOn = true;
            sprite_settings_index = 2;
          }
        }
        
        if (mouseIsOn == false){
          sprite_settings_typing = false;
          
          if (sprites.get(interface1.sprite_selected_index).type == "Background"){
            if (isMouseOn(interface1.sprite_settings_x, interface1.sprite_settings_y, interface1.sprite_settings_width, interface1.sprite_settings_element_height * 1, "CORNER")){
              if (isMouseOn((int) (interface1.sprite_settings_x + interface1.sprite_settings_width - 31.5), (int) (interface1.sprite_settings_y + (0.26f) * interface1.sprite_settings_element_height), 25, 25, "CORNER")){
                interface1.current_interval_types[0] = switchInterval(interface1.current_interval_types[0]);
              }
              else {
                sprite_settings_selected = true;
                sprite_settings_selected_index = 0;
              }
            }
          }
          else if (sprites.get(interface1.sprite_selected_index).type == "Image"){
          
            if (isMouseOn(interface1.sprite_settings_x, interface1.sprite_settings_y, interface1.sprite_settings_width, interface1.sprite_settings_height, "CORNER")){
              boolean isTrue = false;
              
              for (int count = 0; count < interface1.textbox_offset.length; count++){
                if (isMouseOn((int) (interface1.sprite_settings_x + interface1.sprite_settings_width - 31.5), (int) (interface1.sprite_settings_y + (0.26f + count) * interface1.sprite_settings_element_height), 25, 25, "CORNER")){
                  if (count != 6){
                    interface1.current_interval_types[count] = switchInterval(interface1.current_interval_types[count]);
                    isTrue = true;
                    break;
                  }
                }
              }
              
              if (isTrue == false) {
                if (isMouseOn(interface1.sprite_settings_x, interface1.sprite_settings_y, interface1.sprite_settings_width, interface1.sprite_settings_element_height * interface1.current_interval_types.length, "CORNER")){
                  sprite_settings_selected = true;
                  sprite_settings_selected_index = floor((float) (mouseY - interface1.sprite_settings_y) / interface1.sprite_settings_element_height);
                }
                else {
                  sprite_settings_selected = false;
                }
              }
            }
          }
        }
        else {
          sprite_settings_typing = true;
        }
        
        mouseIsOn = false;
      }
      else {
        
        if (isMouseOn(interface1.green_plus_x - 15, interface1.green_plus_y - 15, interface1.green_plus_width, interface1.green_plus_height, "CORNER")){
          
          boolean state_exists = false;
          int previous_state_index = 0;
          
          //for (int count = 0; count < sprites.get(interface1.sprite_selected_index).states.size(); count++){
          //  if (sprites.get(interface1.sprite_selected_index).states.get(count).frame == interface1.playhead_position){
          //    sprites.get(interface1.sprite_selected_index).states.remove(count);
          //    break;
          //  }
          //}
          
          for (int count = 0; count < sprites.get(interface1.sprite_selected_index).states.size(); count++){
            if (sprites.get(interface1.sprite_selected_index).states.get(count).frame == interface1.playhead_position){
              //sprites.get(interface1.sprite_selected_index).states.remove(count);
              state_exists = true;
              break;
            }
          }
          
          if (state_exists == false){
            
            for (State state : sprites.get(interface1.sprite_selected_index).states){
              if (state.frame > interface1.playhead_position){
                //previous_state_index--;
                
                break;
              }
              
              previous_state_index++;
            }
            
            previous_state_index--;
            
            if (sprites.get(interface1.sprite_selected_index).type == "Background"){
              
              State previous_state;
              
              try {
                previous_state = sprites.get(interface1.sprite_selected_index).states.get(previous_state_index);
              }
              catch (Exception e) {
                previous_state = new State(0, new String[]{"linear"}, new int[]{255, 255, 255}, 9);
              }
              
              sprites.get(interface1.sprite_selected_index).states.add(new State(interface1.playhead_position, previous_state.interval_types, previous_state.fill_color, previous_state.layer));
            }
            else if (sprites.get(interface1.sprite_selected_index).type == "Image"){
              
              State previous_state;
              
              try {
                previous_state = sprites.get(interface1.sprite_selected_index).states.get(previous_state_index);
              }
              catch (Exception e) {
                previous_state = new State(0, 0, 0, 0, 0, 0, new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"}, 1, 1);
              }
              
              sprites.get(interface1.sprite_selected_index).states.add(new State(interface1.playhead_position, -1, -1, -1, -1, -1, new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"}, -1, -1));
            }
          }
          
          Collections.sort(sprites.get(interface1.sprite_selected_index).states, new Comparator<State>() {
              @Override public int compare(State p1, State p2) {
                  return Integer.compare(p1.frame, p2.frame); // Ascending
              }
          });
          
          previous_state_index = 0;
          
          for (int i = 0; i < sprites.get(interface1.sprite_selected_index).states.size(); i++){
            if (sprites.get(interface1.sprite_selected_index).states.get(i).frame == interface1.playhead_position){
              previous_state_index = i;
              break;
            }
          }
          
          if (sprites.get(interface1.sprite_selected_index).type == "Background"){
            if (sprite_settings_selected_index == 0){
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).fill_color = interface1.current_fill_color;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).interval_types = interface1.current_interval_types;
            }
          }
          else if (sprites.get(interface1.sprite_selected_index).type == "Image"){
            
            State previous_state;
            
            //try {
            //  previous_state = sprites.get(interface1.sprite_selected_index).states.get(previous_state_index);
            //}
            //catch (Exception e) {
            //  previous_state = new State(0, 0, 0, 0, 0, 0, interface1.current_interval_types, 1, 1);
            //}
            
            //Values
            if (sprite_settings_selected){
              switch (sprite_settings_selected_index){
                case 0:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).x = interface1.current_x;
                break;
                
                case 1:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).y = interface1.current_y;
                break;
                
                case 2:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).image_width = interface1.current_width;
                break;
                
                case 3:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).image_height = interface1.current_height;
                break;
                
                case 4:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).rotation = interface1.current_rotation;
                break;
                
                case 5:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).visibility = interface1.current_visibility;
                break;
                
                case 6:
                  sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).layer = interface1.current_layer;
                break;
              }
            }
            else {
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).x = interface1.current_x;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).y = interface1.current_y;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).image_width = interface1.current_width;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).image_height = interface1.current_height;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).rotation = interface1.current_rotation;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).visibility = interface1.current_visibility;
              sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).layer = interface1.current_layer;
              
            }
            
            sprites.get(interface1.sprite_selected_index).states.get(previous_state_index).interval_types[sprite_settings_selected_index] = interface1.current_interval_types[sprite_settings_selected_index];
          }
          
          for (Sprite sprite : sprites){
            sprite.update();
          }
        }
        else if (isMouseOn(interface1.red_minus_x - 15, interface1.red_minus_y - 15, interface1.red_minus_width, interface1.red_minus_height, "CORNER")){
          
          if (sprites.get(interface1.sprite_selected_index).type == "Image"){
            boolean stateExists = false;
            int index = 0;
            
            for (int count = 0; count < sprites.get(interface1.sprite_selected_index).states.size(); count++){
              if (sprites.get(interface1.sprite_selected_index).states.get(count).frame == interface1.playhead_position){
                stateExists = true;
                index = count;
                break;
              }
            }
            
            if (stateExists){
              if (sprite_settings_selected){
                switch (sprite_settings_selected_index){
                  case 0:
                    sprites.get(interface1.sprite_selected_index).states.get(index).x = -1;
                  break;
                  
                  case 1:
                    sprites.get(interface1.sprite_selected_index).states.get(index).y = -1;
                  break;
                  
                  case 2:
                    sprites.get(interface1.sprite_selected_index).states.get(index).image_width = -1;
                  break;
                  
                  case 3:
                    sprites.get(interface1.sprite_selected_index).states.get(index).image_height = -1;
                  break;
                  
                  case 4:
                    sprites.get(interface1.sprite_selected_index).states.get(index).rotation = -1;
                  break;
                  
                  case 5:
                    sprites.get(interface1.sprite_selected_index).states.get(index).visibility = -1;
                  break;
                  
                  case 6:
                    sprites.get(interface1.sprite_selected_index).states.get(index).layer = -1;
                  break;
                }
                
                if (sprites.get(interface1.sprite_selected_index).states.get(index).x == -1 &&
                    sprites.get(interface1.sprite_selected_index).states.get(index).y == -1 &&
                    sprites.get(interface1.sprite_selected_index).states.get(index).image_width == -1 &&
                    sprites.get(interface1.sprite_selected_index).states.get(index).image_height == -1 &&
                    sprites.get(interface1.sprite_selected_index).states.get(index).rotation == -1 &&
                    sprites.get(interface1.sprite_selected_index).states.get(index).visibility == -1 &&
                    sprites.get(interface1.sprite_selected_index).states.get(index).layer == -1)
                {
                  sprites.get(interface1.sprite_selected_index).states.remove(index);
                }
              }
              else {
                sprites.get(interface1.sprite_selected_index).states.remove(index);
              }
            }
          }
          else if (sprites.get(interface1.sprite_selected_index).type == "Background"){
            boolean stateExists = false;
            int index = 0;
            
            for (int count = 0; count < sprites.get(interface1.sprite_selected_index).states.size(); count++){
              if (sprites.get(interface1.sprite_selected_index).states.get(count).frame == interface1.playhead_position){
                stateExists = true;
                index = count;
                break;
              }
            }
            
            if (stateExists){
              sprites.get(interface1.sprite_selected_index).states.remove(index);
            }
          }
          
          updateCurrentState();
          updateTextboxWidths();
          
          for (Sprite sprite : sprites){
            sprite.update();
          }
        }
        else {
          
          sprite_settings_selected = false;
          
          if (cursor != "ARROW"){
            cursor(ARROW);
            cursor = "ARROW";
          }
        }
      }
      
      if (isMouseOn(interface1.sprite_window_x, interface1.sprite_window_y, interface1.sprite_window_width, interface1.sprite_element_height * sprites.size(), "CORNER")){
        interface1.sprite_selected_index = floor((float) (mouseY - interface1.sprite_window_y + interface1.sprite_window_offset % interface1.sprite_element_height) / (float) interface1.sprite_element_height) + floor(interface1.sprite_window_offset / interface1.sprite_element_height);
        interface1.sprite_selected = true;
        
        updateCurrentState();
        updateTextboxWidths();
      }
      else if (isMouseOn(interface1.timeline_x, interface1.timeline_y, interface1.timeline_width, interface1.timeline_height, "CORNER") || isMouseOn(interface1.scroll_bar_x, interface1.scroll_bar_y, interface1.scroll_bar_width, interface1.scroll_bar_height, "CORNER") || isMouseOn(interface1.sprite_settings_x, interface1.sprite_settings_y, interface1.sprite_settings_width, interface1.sprite_settings_height, "CORNER")){
        
      }
      else if (isMouseOn(interface1.green_plus_x - 15, interface1.green_plus_y - 15, interface1.green_plus_width, interface1.green_plus_height, "CORNER") || isMouseOn(interface1.red_minus_x - 15, interface1.red_minus_y - 15, interface1.red_minus_width, interface1.red_minus_height, "CORNER")){
        
      }
      //Mouse on play / stop buttons
      else if (isMouseOn(interface1.play_button_x - (int) (interface1.play_stop_buttons_width / 2), interface1.play_button_y - (int) (interface1.play_stop_buttons_width / 2), interface1.play_stop_buttons_width, interface1.play_stop_buttons_width, "CORNER")){
        interface1.playing = true;
      }
      else if (isMouseOn(interface1.stop_button_x - (int) (interface1.play_stop_buttons_width / 2), interface1.stop_button_y - (int) (interface1.play_stop_buttons_width / 2), interface1.play_stop_buttons_width, interface1.play_stop_buttons_width, "CORNER")){
        interface1.playing = false;
      }
      else if (isMouseOn(interface1.snap_button_x - 15, interface1.snap_button_y - 15, 30, 30, "CORNER")){
        if (is_snap_pressed == false){
          is_snap_pressed = true;
        }
        else {
          is_snap_pressed = false;
        }
      }
      else if (sprites.get(interface1.sprite_selected_index).states.size() > 1 && isMouseOn((int) (interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) interface1.latest_x / 1920f)) - 10, (int) (interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) interface1.latest_y / 1080f)) - 10, interface1.timeline_state_width + 20, interface1.timeline_state_width + 20, "CORNER")) {
        sprite_dragging = true;
      }
      else if (sprites.get(interface1.sprite_selected_index).states.size() > 1 && isMouseOn((int) (interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) interface1.latest_x / 1920f) + sin(radians(interface1.latest_rotation)) * interface1.rotation_slider_distance) - 10, (int) (interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) interface1.latest_y / 1080f) + -cos(radians(interface1.latest_rotation)) * interface1.rotation_slider_distance) - 10, 20, 20, "CORNER")){
        sprite_rotating = true;
      }
      else if (sprites.get(interface1.sprite_selected_index).states.size() <= 1 && isMouseOn((int) (interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) interface1.current_x / 1920f)) - 10, (int) (interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) interface1.current_y / 1080f)) - 10, interface1.timeline_state_width + 20, interface1.timeline_state_width + 20, "CORNER")){
        sprite_dragging = true;
      }
      else if (sprites.get(interface1.sprite_selected_index).states.size() <= 1 && isMouseOn((int) (interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) interface1.current_x / 1920f) + sin(radians(interface1.latest_rotation)) * interface1.rotation_slider_distance) - 10, (int) (interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) interface1.current_y / 1080f) + -cos(radians(interface1.latest_rotation)) * interface1.rotation_slider_distance) - 10, 20, 20, "CORNER")){
        sprite_rotating = true;
      }
      else if (isMouseOn(interface1.animation_window_x - 10, interface1.animation_window_y - 10, interface1.animation_window_width + 20, interface1.animation_window_height + 20, "CORNER")){
        
      }
      else if (isMouseOn(interface1.sprite_mode_x - 16, interface1.sprite_mode_y - 10, 32, 20, "CORNER")){
        if (sprite_mode){
          sprite_mode = false;
        }
        else {
          sprite_mode = true;
        }
      }
      else if (isMouseOn(interface1.instant_updates_x - 25, interface1.instant_updates_y - 25, 50, 50, "CORNER")){
        if (instant_update){
          instant_update = false;
        }
        else {
          instant_update = true;
        }
      }
      else {
        interface1.sprite_selected = false;
      }
      
      if (isMouseOn(interface1.export_button_x - 25, interface1.export_button_y - 25, 50, 50, "CORNER")){
        interface1.mode = "Export";
        interface1.playhead_position = 0;
        exportVideo();
      }
      
      //open new file
      //if (isMouseOn(interface1.rect_x, interface1.rect_y, interface1.rect_width, interface1.rect_height, "CORNER")){
      //  open_file();
      //}
      if (isMouseOn(interface1.settings_x - 26, interface1.settings_y - 26, 52, 52, "CORNER")){
        interface1.mode = "Options";
      }
      else if (isMouseOn(interface1.scroll_bar_x, interface1.scroll_bar_y, interface1.scroll_bar_width, interface1.scroll_bar_height, "CORNER")){
        scrollbar_moving = true;
      }
      else if (isMouseOn(interface1.timeline_x, interface1.timeline_y, interface1.timeline_width, interface1.timeline_height, "CORNER")){
        interface1.playhead_position = round(interface1.scroll + float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width * interface1.zoom_levels[interface1.zoom] * 15);
        playhead_moving = true;
        
       if (interface1.playhead_position < 0){
          interface1.playhead_position = 0;
        }
        else if (interface1.playhead_position > interface1.videoLength){
          interface1.playhead_position = interface1.videoLength;
        }
        
        updateCurrentState();
        updateTextboxWidths();
      }
    }
    
    //right mouse button
    else if (mouseButton == RIGHT){
      //clicked on sprite
    }
  }
  else if (interface1.mode == "Name_Sprite"){
    if (mouseButton == LEFT){
      //textBox
      if (isMouseOn(interface1.tBox_x, interface1.tBox_y, interface1.tBox_width, interface1.tBox_height, "CORNER")){
        interface1.textBox_clicked = true;
      }
      else {
        interface1.textBox_clicked = false;
        //checkmark
        if (isMouseOn(interface1.tBox_x + interface1.tBox_width + 50, interface1.tBox_y, 50, 50, "CORNER")){
          if (interface1.currentName != ""){
            sprites.get(sprites.size() - 1).name = interface1.currentName;
            interface1.mode = "Animation_Editor";
          }
        }
      }
    }
  }
  else if (interface1.mode == "Options"){
    if (mouseButton == LEFT){
      if (isMouseOn(interface1.settings_x - 26, interface1.settings_y - 26, 52, 52, "CORNER")){
        interface1.mode = "Animation_Editor";
      }
      else if (isMouseOn(interface1.vqs_x, interface1.vqs_y, interface1.vqs_width, interface1.vqs_height, "CORNER")){
        video_quality_clicked = true;
      }
      else if (isMouseOn(interface1.frs_x, interface1.frs_y, interface1.frs_width, interface1.frs_height, "CORNER")){
        framerate_clicked = true;
      }
    }
  }
}

void mouseReleased(){
  
  if (interface1.mode == "Options"){
    if (mouseButton == LEFT){
      if (video_quality_clicked == true){
        video_quality_clicked = false;
      }
      else if (framerate_clicked == true){
        framerate_clicked = false;
      }
    }
  }
  else if (interface1.mode == "Animation_Editor"){
    scrollbar_moving = false;
    playhead_moving = false;
    sprite_window_scrollbar_moving = false;
    sprite_dragging = false;
    sprite_rotating = false;
  }
}

void keyPressed(){
  //if (key == 'q'){
  //  videoExport.endMovie();
  //  exit();
  //}
  if (interface1.mode == "Name_Sprite"){
    //textBox pressed
    if (interface1.textBox_clicked == true){
      if (keyCode == BACKSPACE){
        //name length
        if (interface1.name_length > 0){
          interface1.currentName = interface1.currentName.substring(0, interface1.name_length - 1);
          interface1.name_length--;
        }
      }
      //name length
      else if (interface1.name_length < 14){
        if (keyCode != ENTER && keyCode != RETURN){
          interface1.currentName = interface1.currentName + char(key);
          interface1.name_length++;
        }
      }
    }
  }
  else if (interface1.mode == "Animation_Editor"){
    if (keyCode == CONTROL){
      ctrl_pressed = true;
    }
    else if (keyCode == SHIFT){
      shift_clicked = true;
    }
    else if (key == 'r'){
      updateCurrentState();
      updateTextboxWidths();
    }
    else if (key == 't'){
      if (is_snap_pressed == false){
        is_snap_pressed = true;
      }
      else {
        is_snap_pressed = false;
      }
    }
    else if (key == 'f'){
      if (sprite_mode){
        sprite_mode = false;
      }
      else {
        sprite_mode = true;
      }
    }
    else if (key == 'g'){
      if (instant_update){
        instant_update = false;
      }
      else {
        instant_update = true;
      }
    }
    else if (key == 'c'){
      println("oop");
      if (interface1.sprite_selected){
        copied_sprite = sprites.get(interface1.sprite_selected_index);
      }
    }
    else if (key == 'v'){
      if (copied_sprite != null){
        sprites.add(copied_sprite);
      }
    }
    else if (keyCode == DOWN){
      if (sprite_settings_selected){
        if (sprite_settings_selected_index < interface1.current_interval_types.length - 1){
          sprite_settings_selected_index++;
        }
      }
      else if (interface1.sprite_selected){
        if (interface1.sprite_selected_index < sprites.size() - 1){
          interface1.sprite_selected_index++;
        }
      }
    }
    else if (keyCode == UP){
      if (sprite_settings_selected){
        if (sprite_settings_selected_index > 0){
          sprite_settings_selected_index--;
        }
      }
      else if (interface1.sprite_selected){
        if (interface1.sprite_selected_index > 0){
          interface1.sprite_selected_index--;
        }
      }
    }
    else if (keyCode == RIGHT){
      if (shift_clicked == true){
        //if (interface1.scroll + 10 <= interface1.videoLength - (interface1.zoom_levels[interface1.zoom] * 15)){
        //  interface1.scroll += 10;
        //}
        if (interface1.playhead_position + 10 <= interface1.videoLength - 1){
          interface1.playhead_position += 10;
        }
        else {
          //interface1.scroll = interface1.videoLength - (interface1.zoom_levels[interface1.zoom] * 15);
          interface1.playhead_position = interface1.videoLength - 1;
        }
      }
      else {
        //if (interface1.scroll + 1 <= interface1.videoLength - (interface1.zoom_levels[interface1.zoom] * 15)){
        //  interface1.scroll++;
        //}
        if (interface1.playhead_position + 1 <= interface1.videoLength - 1){
          interface1.playhead_position++;
        }
      }
      
      if (interface1.playhead_position - interface1.scroll - interface1.zoom_levels[interface1.zoom] * 15 > 0){
        interface1.scroll = interface1.playhead_position - interface1.zoom_levels[interface1.zoom] * 15;
      }
      
      updateCurrentState();
      updateTextboxWidths();
    }
    else if (keyCode == LEFT){
      if (shift_clicked == true){
        //if (interface1.scroll - 10 >= 0){
        //  interface1.scroll -= 10;
        //}
        if (interface1.playhead_position - 10 >= 0){
          interface1.playhead_position -= 10;
        }
        else {
          //interface1.scroll = 0;
          interface1.playhead_position = 0;
        }
      }
      else {
        //if (interface1.scroll - 1 >= 0){
        //  interface1.scroll--;
        //}
        if (interface1.playhead_position - 1 >= 0){
          interface1.playhead_position--;
        }
      }
      
      if (interface1.playhead_position - interface1.scroll < 0){
        interface1.scroll = interface1.playhead_position;
      }
      
      updateCurrentState();
      updateTextboxWidths();
    }
    else if ((sprite_settings_typing == true && keyCode - 48 >= 0 && keyCode - 48 <= 9) || key == '.'){
      if (sprites.get(interface1.sprite_selected_index).type == "Image"){
        if (key == '.'){
          if (sprite_settings_index == 4){
            floats[sprite_settings_index] += ".";
          }
          else if (sprite_settings_index == 5){
            floats[sprite_settings_index] += ".";
          }
        }
        else {
          switch (sprite_settings_index){
            case 0:
              if (str(interface1.current_x).length() < 4){
                interface1.current_x = int(str(interface1.current_x) + str(key));
              }
            break;
            
            case 1:
              if (str(interface1.current_y).length() < 4){
                interface1.current_y = int(str(interface1.current_y) + str(key));
              }
            break;
            
            case 2:
              if (str(interface1.current_width).length() < 4){
                interface1.current_width = int(str(interface1.current_width) + str(key));
              }
            break;
            
            case 3:
              if (str(interface1.current_height).length() < 4){
                interface1.current_height = int(str(interface1.current_height) + str(key));
              }
            break;
            
            case 4:
              if (floats[sprite_settings_index].length() < 5){
                floats[sprite_settings_index] += str(key);
              }
            break;
            
            case 5:
              if (floats[sprite_settings_index].length() < 5){
                floats[sprite_settings_index] += str(key);
              }
            break;
            
            case 6:
              if (interface1.current_layer == 0){
                interface1.current_layer = int(str(interface1.current_layer) + str(key));
              }
            break;
          }
        }
      }
      else if (sprites.get(interface1.sprite_selected_index).type == "Background"){
        switch (sprite_settings_index){
          case 0:
              if (str(interface1.current_fill_color[0]).length() < 3){
                interface1.current_fill_color[0] = int(str(interface1.current_fill_color[0]) + str(key));
              }
            break;
            
            case 1:
              if (str(interface1.current_fill_color[1]).length() < 3){
                interface1.current_fill_color[1] = int(str(interface1.current_fill_color[1]) + str(key));
              }
            break;
            
            case 2:
              if (str(interface1.current_fill_color[2]).length() < 3){
                interface1.current_fill_color[2] = int(str(interface1.current_fill_color[2]) + str(key));
              }
            break;
        }
      }
      
      updateTextboxWidths();
    }
    else if (sprite_settings_typing == true && keyCode == BACKSPACE){
      
      if (sprites.get(interface1.sprite_selected_index).type == "Image"){
        
        switch (sprite_settings_index){
          case 0:
            if (str(interface1.current_x).length() > 0){
              interface1.current_x = int(str(interface1.current_x).substring(0, str(interface1.current_x).length() - 1));
            }
          break;
          
          case 1:
            if (str(interface1.current_y).length() > 0){
              interface1.current_y = int(str(interface1.current_y).substring(0, str(interface1.current_y).length() - 1));
            }
          break;
          
          case 2:
            if (str(interface1.current_width).length() > 0){
              interface1.current_width = int(str(interface1.current_width).substring(0, str(interface1.current_width).length() - 1));
            }
          break;
          
          case 3:
            if (str(interface1.current_height).length() > 0){
              interface1.current_height = int(str(interface1.current_height).substring(0, str(interface1.current_height).length() - 1));
            }
          break;
          
          case 4:
            if (floats[sprite_settings_index].length() > 1){
              floats[sprite_settings_index] = floats[sprite_settings_index].substring(0, floats[sprite_settings_index].length() - 1);
            }
            else {
              floats[sprite_settings_index] = "";
            }
          break;
          
          case 5:
            if (floats[sprite_settings_index].length() > 1){
              floats[sprite_settings_index] = floats[sprite_settings_index].substring(0, floats[sprite_settings_index].length() - 1);
            }
            else {
              floats[sprite_settings_index] = "";
            }
          break;
          
          case 6:
            if (str(interface1.current_layer).length() > 0){
              interface1.current_layer = int(str(interface1.current_layer).substring(0, str(interface1.current_layer).length() - 1));
            }
          break;
        }
      }
      else if (sprites.get(interface1.sprite_selected_index).type == "Background"){
        switch (sprite_settings_index){
          case 0:
            if (str(interface1.current_fill_color[0]).length() > 0){
              interface1.current_fill_color[0] = int(str(interface1.current_fill_color[0]).substring(0, str(interface1.current_fill_color[0]).length() - 1));
            }
          break;
          
          case 1:
            if (str(interface1.current_fill_color[1]).length() > 0){
              interface1.current_fill_color[1] = int(str(interface1.current_fill_color[1]).substring(0, str(interface1.current_fill_color[1]).length() - 1));
            }
          break;
          
          case 2:
            if (str(interface1.current_fill_color[2]).length() > 0){
              interface1.current_fill_color[2] = int(str(interface1.current_fill_color[2]).substring(0, str(interface1.current_fill_color[2]).length() - 1));
            }
          break;
        }
      }
      
      updateTextboxWidths();
    }
    //Spacebar
    else if (keyCode == 32){
      if (interface1.playing){
        interface1.playing = false;
      }
      else {
        interface1.playing = true;
      }
    }
  }
}

void keyReleased(){
  if (interface1.mode == "Animation_Editor"){
    if (keyCode == CONTROL){
      ctrl_pressed = false;
    }
    else if (keyCode == SHIFT){
      shift_clicked = false;
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (ctrl_pressed == true){
    if (interface1.zoom_available == true) {
      if (e < 0){
        if (interface1.zoom > 0){
          interface1.zoom -= 1;
          
          if ((float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width) * interface1.zoom_levels[interface1.zoom] * 15 < 0){
            interface1.scroll += 0;
          }
          else if ((float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width) * interface1.zoom_levels[interface1.zoom] * 15 > interface1.zoom_levels[interface1.zoom] * 15){
            interface1.scroll += interface1.zoom_levels[interface1.zoom] * 15;
          }
          else {
            interface1.scroll += int((float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width) * interface1.zoom_levels[interface1.zoom] * 15);
          }
        
        }
      }
      else if (e > 0){
        if (interface1.zoom < interface1.zoom_levels.length - 1){
          if (interface1.zoom_levels[interface1.zoom + 1] * 15 <= interface1.videoLength){
            interface1.zoom += 1;
            
            if ((float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width) * interface1.zoom_levels[interface1.zoom] * 15 < 0){
              interface1.scroll -= 0;
            }
            else if ((float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width) * interface1.zoom_levels[interface1.zoom] * 15 > interface1.zoom_levels[interface1.zoom] * 15){
              interface1.scroll += interface1.zoom_levels[interface1.zoom] * 15;
            }
            else {
              interface1.scroll -= int((float(mouseX - interface1.scroll_bar_x) / interface1.timeline_width) * interface1.zoom_levels[interface1.zoom] * 15);
            }
            
            //Change timeline scroll
            if (interface1.scroll > interface1.videoLength - (interface1.zoom_levels[interface1.zoom] * 15)){
              interface1.scroll = interface1.videoLength - (interface1.zoom_levels[interface1.zoom] * 15);
            }
            else if (interface1.scroll < 0){
              interface1.scroll = 0;
            }
          }
        }
      }
    }
  }
}

void draw(){
  
  if (mouse_pressed_wait){
    mousePressedEvent();
    
    mouse_pressed_wait = false;
  }
  
  //background
  if (interface1.mode == "Animation_Editor"){
    //Draw frame in animation window
    for (int layer = 9; layer > 0; layer--){
      
      if (sprite_mode){
        //Show preview of all sprites
        for (int i = 0; i < sprites.size(); i++){
          sprites.get(i).showPreview(layer, i);
        }
      }
      else {
        //Show preview of only this sprite
        sprites.get(0).showPreview(layer, interface1.sprite_selected_index);
        
        if (interface1.sprite_selected_index > 0){
          sprites.get(interface1.sprite_selected_index).showPreview(layer, interface1.sprite_selected_index);
        }
      }
    }
    
    //Fill in background except for animation window
    noStroke();
    fill(background_color[0], background_color[1], background_color[2]);
    rect(0, 0, width, interface1.animation_window_y);
    rect(0, interface1.animation_window_y, interface1.animation_window_x, height - interface1.animation_window_y);
    rect(interface1.animation_window_x + interface1.animation_window_width, interface1.animation_window_y, interface1.animation_window_x, height - interface1.animation_window_y);
    rect(interface1.animation_window_x, interface1.animation_window_y + interface1.animation_window_height, interface1.animation_window_width, height - interface1.animation_window_y - interface1.animation_window_height);
  }
  else if (interface1.mode == "Export"){
    for (int layer = 9; layer > 0; layer--){
      for (int i = 0; i < sprites.size(); i++){
        sprites.get(i).show(layer, i);
      }
    }
    
    videoExport.saveFrame();
    
    stroke(0);
    strokeWeight(2);
    fill(255);
    rect(760, 1000, 400, 20);
    fill(0, 200, 0);
    noStroke();
    rect(761, 1001, ((float) interface1.playhead_position / (float) interface1.last_frame) * 400f, 19);
    
    frame_decimal += 60f / (float) interface1.framerate;
    
    interface1.playhead_position = round(frame_decimal);
    
    if (interface1.playhead_position > interface1.last_frame){
      videoExport.endMovie();
      interface1.mode = "Animation_Editor";
      interface1.playhead_position = 0;
      updateCurrentState();
      updateTextboxWidths();
      
      shift_clicked = false;
      ctrl_pressed = false;
      scrollbar_moving = false;
      playhead_moving = false;
      sprite_dragging = false;
      mouse_pressed_wait = false;
      
      frame_decimal = 0;
    }
  }
  else {
    background(background_color[0], background_color[1], background_color[2]);
  }
  
  //Update file opening
  if (fileOpened == true){
    sprites.add(new Sprite("Image", recent_image));
    
    image_file_num++;
    interface1.mode = "Name_Sprite";
    interface1.currentName = "";
    interface1.name_length = 0;
    
    fileOpened = false;
  }
  
  //Show interface
  interface1.show();
  
  //try {
  //  println(sprites.get(1).states.get(1).frame);
  //}
  //catch (Exception e){
    
  //}
  
  //videoExport.saveFrame();
}
