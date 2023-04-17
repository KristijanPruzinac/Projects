class Interface {
  //modes "Animation_Editor", "Name_Sprite", "Options", "Export"
  String mode = "Animation_Editor";
  
  //animation window
  int y_value = 0;
  
  int animation_window_x = 384;
  int animation_window_y = 125;
  int animation_window_width = 1152;
  int animation_window_height = 648;
  
  
  //Play / Stop button common settings
  int play_stop_buttons_dist = 70;
  int play_stop_buttons_window_offset = 35;
  int play_stop_buttons_width = 30;
  
  //Play button
  int play_button_x = animation_window_x + (animation_window_width / 2) - play_stop_buttons_dist / 2;
  int play_button_y = animation_window_y + animation_window_height + play_stop_buttons_window_offset;
  
  //Stop button
  int stop_button_x = animation_window_x + (animation_window_width / 2) + play_stop_buttons_dist / 2;
  int stop_button_y = animation_window_y + animation_window_height + play_stop_buttons_window_offset;
  
  //Playing
  boolean playing = false;
  
  //sprite window
  int sprite_window_x = 1580;
  int sprite_window_y = 100;
  int sprite_window_width = 300;
  int sprite_window_height = 700;
  
  int sprite_element_height = 50;
  
  int sprite_window_scrollbar_x = sprite_window_x + sprite_window_width + 10;
  int sprite_window_scrollbar_y = sprite_window_y;
  int sprite_window_scrollbar_width = 20;
  int sprite_window_scrollbar_height = sprite_window_height;
  
  int sprite_window_offset_height = 0;
  
  int sprite_window_scrollbar_length = 0;
  
  int sprite_window_offset = 0;
  
  //Sprite settings window
  int sprite_settings_x = 20;
  int sprite_settings_y = 100;
  int sprite_settings_width = 320;
  int sprite_settings_height = 700;
  
  int sprite_settings_element_height = 50;
  
  //new image button
  int rect_x = 1650;
  int rect_y = 825;
  int rect_width = 200;
  int rect_height = 50;
  
  //settings button
  int settings_x = 1920 - 25 - 10;
  int settings_y = 1080 - 25 - 10;

  //Sprite settings
  
  int textbox_width_offset = 5;
  
  String previous_type = "Image";
  
  int[] textbox_width;
  int[] textbox_offset;
  int[] current_fill_color;
  
  String[] texts;

  //textbox
  int tBox_x = 735;
  int tBox_y = 515;
  int tBox_width = 300;
  int tBox_height = 50;
  
  String currentName;
  
  int name_length;
  
  Boolean textBox_clicked = false;
  
  //timeline
  int timeline_x = 210;
  int timeline_y = 925;
  int timeline_width = 1500;
  int timeline_height = 125;
  
  int timeline_state_width = 10;
  
  int zoom = 5;
  
  int videoLength = 10  //minutes
                   *60  //seconds
                   *60; //frames
  
  int scroll = 0;
  
  int playhead_position = 0;
  
  Boolean zoom_available = true;
  
  int[] zoom_levels = {1, 2, 5, 10, 30, 60, 120, 240, 600, 1200, 2400, 4800};
  //int[] zoom_levels = {1, 2, 4, 30, 60, 120, 240, 600};
  
  int element_dist = 100;
  
  int m;
  int s;
  int f;
  
  String ms;
  String ss;
  String fs;
  
  int sprite_selected_index = 0;
  
  int sprite_hovered_index = 0;
  
  boolean sprite_hovered = false;
  
  boolean sprite_selected = false;
  
  //current settings
  int current_x = 0;
  int current_y = 0;
  
  int current_width = 0;
  int current_height = 0;
  
  float current_rotation = 0;
  
  int current_layer = 0;
  
  float current_visibility = 0;
  
  String[] current_interval_types;
  
  //latest settings
  int latest_x = 0;
  int latest_y = 0;
  float latest_rotation = 0;
  
  int rotation_slider_distance = 50;
  
  //actual settings
  int video_quality = 100;
  float framerate = 60;
  
  //video quality slider
  int vqs_x = 325;
  int vqs_y = 25;
  int vqs_width = 200;
  int vqs_height = 50;
  
  //framerate slider
  int frs_x = 325;
  int frs_y = 100;
  int frs_width = 240;
  int frs_height = 50;
  
  //scroll bar
  int scroll_bar_x = timeline_x - 2;
  int scroll_bar_y = timeline_y + 130;
  int scroll_bar_width = 1504;
  int scroll_bar_height = 20;
  
  int scroll_x;
  int scroll_y = scroll_bar_y + 1;
  int scroll_width;
  int scroll_height = scroll_bar_height - 1;
  
  //(Add | Remove) state buttons
  int green_plus_x = sprite_settings_x + sprite_settings_width - 75;
  int green_plus_y = sprite_settings_y + sprite_settings_height + 30;
  int green_plus_width = 30;
  int green_plus_height = 30;
  
  int red_minus_x = sprite_settings_x + sprite_settings_width - 15;
  int red_minus_y = sprite_settings_y + sprite_settings_height + 30;
  int red_minus_width = 30;
  int red_minus_height = 30;
  
  //zoom indicator
  int zoom_width = 200;
  int zoom_x = (timeline_x + (timeline_width / 2)) - (zoom_width / 2);
  int zoom_y = 860;
  
  //Snap button
  int snap_button_x = 180;
  int snap_button_y = 956;
  
  //Export button
  int export_button_x = 1810;
  int export_button_y = 1045;
  
  //Last state frame
  int last_frame = 0;
  
  //Sprite drag element
  int sprite_drag_snap_size = 20;
  
  //Sprite visibility mode button
  int sprite_mode_x = 1500;
  int sprite_mode_y = 800;
  
  //Instant update button
  int instant_updates_x = 210;
  int instant_updates_y = 830;
  
  //Sprite rotation box snap
  float rotation_box_snap = 22.5;
  
  Interface(){
    
    textbox_width = new int[7];
    
    textbox_width[0] = 25;
    textbox_width[1] = 25;
    textbox_width[2] = 25;
    textbox_width[3] = 25;
    textbox_width[4] = 25;
    textbox_width[5] = 25;
    textbox_width[6] = 25;
    
    textbox_offset = new int[7];
    
    textbox_offset[0] = 150;
    textbox_offset[1] = 150;
    textbox_offset[2] = 200;
    textbox_offset[3] = 210;
    textbox_offset[4] = 225;
    textbox_offset[5] = 230;
    textbox_offset[6] = 190;
    
    texts = new String[7];
    texts[0] = "Position x";
    texts[1] = "Position y";
    texts[2] = "Element width";
    texts[3] = "Element height";
    texts[4] = "Element rotation";
    texts[5] = "Element visibility";
    texts[6] = "Element layer";
    
    current_fill_color = new int[3];
    current_fill_color[0] = 255;
    current_fill_color[1] = 255;
    current_fill_color[2] = 255;
  }
  
  void show(){
    if (mode == "Animation_Editor"){
      
      if (sprite_dragging){
        current_x = int((float) (mouseX - animation_window_x) * (float) (1920f / animation_window_width));
        current_y = int((float) (mouseY - animation_window_y) * (float) (1080f / animation_window_height));
        
        if (is_snap_pressed){
          current_x = round(current_x / sprite_drag_snap_size) * sprite_drag_snap_size;
          current_y = round(current_y / sprite_drag_snap_size) * sprite_drag_snap_size;
        }
        
        if (current_x > 1919){
          current_x = 1919;
        }
        else if (current_x < 0){
          current_x = 0;
        }
        
        if (current_y > 1079){
          current_y = 1079;
        }
        else if (current_y < 0){
          current_y = 0;
        }
        
        latest_x = current_x;
        latest_y = current_y;
        
        //if (instant_update){
        //  boolean stateExists = false;
        //  int index = 0;
          
        //  for (State state : sprites.get(sprite_selected_index).states){
            
        //    if (state.frame == playhead_position){
        //      stateExists = true;
        //      break;
        //    }
            
        //    index++;
        //  }
          
        //  if (stateExists){
        //    sprites.get(sprite_selected_index).states.get(index).x = current_x;
        //    sprites.get(sprite_selected_index).states.get(index).y = current_y;
        //  }
          
        //  update_penalty = true;
        //}
        
        //updateCurrentState();
        updateTextboxWidths();
      }
      else if (sprite_rotating){
        
        current_rotation = round(((degrees(atan2(mouseY - (int) (interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) interface1.latest_y / 1080f)), mouseX - (int) (animation_window_x + (float) (animation_window_width) * ((float) current_x / 1920f)))) + 180 + 270) % 360));
      
        if (is_snap_pressed){
          current_rotation = round(current_rotation / (float) rotation_box_snap) * (float) rotation_box_snap;
        }
      
        latest_rotation = current_rotation;
        
        updateTextboxWidths();
      }
      
      if (sprite_window_scrollbar_moving){
        //sprite_window_offset_height = (int) (mouseY - sprite_window_scrollbar_y - sprite_window_scrollbar_length / 2f - sprite_window_scrollbar_moving_offset);
        sprite_window_offset = (int) ((mouseY - sprite_window_scrollbar_length / 2f - sprite_window_scrollbar_moving_offset) * ((sprites.size() * sprite_element_height) / (float) sprite_window_scrollbar_height));
        
        if (sprites.size() > 14){
          if (sprite_window_offset > (sprites.size() - 14) * sprite_element_height){
            sprite_window_offset = (sprites.size() - 14) * sprite_element_height;
          }
          else if (sprite_window_offset < 0){
            sprite_window_offset = 0;
          }
        }
        else {
          if (sprite_window_offset > 0){
            sprite_window_offset = 0;
          }
          else if (sprite_window_offset < 0){
            sprite_window_offset = 0;
          }
        }
        
        sprite_window_offset_height = (int) (((float) sprite_window_scrollbar_height / sprites.size()) * (sprite_window_offset / 50f));
      }
      else {
        sprite_window_offset_height = (int) (((float) sprite_window_scrollbar_height / sprites.size()) * (sprite_window_offset / 50f));
      }
      
      if (playing == true){
        playhead_position++;
        updateCurrentState();
        updateTextboxWidths();
        
        if (playhead_position > videoLength - 1){
          playhead_position = videoLength - 1;
        }
        
        //Adjust scroll to match playhead
        if (interface1.playhead_position > interface1.scroll + interface1.zoom_levels[interface1.zoom] * 15){
          interface1.scroll = interface1.playhead_position - interface1.zoom_levels[interface1.zoom] * 15;
        }
      }
      else {
        if (playhead_position > videoLength - 1){
          playhead_position = videoLength - 1;
        }
      }
      
      if (playhead_moving == true){
        if (is_snap_pressed){
          playhead_position = round(round(scroll + float(mouseX - scroll_bar_x) / timeline_width * zoom_levels[zoom] * 15) / 10f) * 10;
        }
        else {
          playhead_position = round(scroll + float(mouseX - scroll_bar_x) / timeline_width * zoom_levels[zoom] * 15);
        }
        
        if (playhead_position < scroll){
          playhead_position = scroll;
        }
        else if (playhead_position > scroll + zoom_levels[zoom] * 15){
          playhead_position = scroll + zoom_levels[zoom] * 15;
        }
        
        updateCurrentState();
        updateTextboxWidths();
      }
      
      if (scrollbar_moving == true){
        scroll = round(((mouseX - scroll_bar_x - int(float(zoom_levels[zoom] * 15) / float(videoLength) * float(scroll_bar_width)) / 2) / float(scroll_bar_width)) * videoLength);
        
        if (scroll < 0){
          scroll = 0;
        }
        else if (scroll > videoLength - (zoom_levels[zoom] * 15)){
          scroll = videoLength - (zoom_levels[zoom] * 15);
        }
      }
      
      //Check if out of bounds
      if (playhead_position > videoLength - 1){
        playhead_position = videoLength - 1;
      }
      
      //animation window
      //noFill();
      ////stroke(100);
      ////strokeWeight(1);
      //noStroke();
      //rect(animation_window_x + 1, animation_window_y + 1, animation_window_width, animation_window_height);
      
      //sprites
      textAlign(LEFT, CENTER);
      fill(200);
      strokeWeight(1);
      stroke(255);
      rect(sprite_window_x, sprite_window_y, sprite_window_width, sprite_window_height);
      
      if (sprite_hovered == true){
        fill(180);
        noStroke();
        rect(sprite_window_x + 2, sprite_window_y + sprite_element_height * sprite_hovered_index - sprite_window_offset, sprite_window_width - 4, sprite_element_height);
      }
      if (sprite_selected == true){
        fill(160);
        noStroke();
        rect(sprite_window_x + 2, sprite_window_y + sprite_element_height * sprite_selected_index - sprite_window_offset, sprite_window_width - 4, sprite_element_height);
      }
      
      //Sprite window scrollbar
      
      if (sprites.size() > 14){
        sprite_window_scrollbar_length = (int) (sprite_window_scrollbar_height / (sprites.size() / 14f));
      }
      else {
        sprite_window_scrollbar_length = sprite_window_scrollbar_height;
      }
      
      stroke(100);
      strokeWeight(1);
      noFill();
      rect(sprite_window_scrollbar_x, sprite_window_scrollbar_y, sprite_window_scrollbar_width, sprite_window_scrollbar_height);
      
      noStroke();
      fill(255);
      rect(sprite_window_scrollbar_x + 1, sprite_window_scrollbar_y + sprite_window_offset_height, sprite_window_scrollbar_width - 2, sprite_window_scrollbar_length);
      
      //Sprite window
      
      y_value = 0;
      noFill();
      stroke(255);
      strokeWeight(1);
      
      int sprites_scrolled = floor(sprite_window_offset / sprite_element_height);
      
      if (sprites.size() > 14){
        for (int index = sprites_scrolled; index < sprites_scrolled + 15; index++){
          try {
            noFill();
            rect(sprite_window_x, sprite_window_y + (y_value * 50) - sprite_window_offset % 50, 300, sprite_element_height);
            textSize(25);
            fill(0);
            
            text(sprites.get(index).name, sprite_window_x + 25, sprite_window_y + (y_value * 50) + (sprite_element_height / 2) - sprite_window_offset % 50);
            
            try {
              switch (sprites.get(index).type){
                case "Image":
                  image(sprites.get(index).image, sprite_window_x + 275 + 1, sprite_window_y + 25 + (y_value * 50) - sprite_window_offset % 50 + 1, 50 - 1, 50 - 1);
                break;
                
                case "Background":
                  image(background_icon, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50) - sprite_window_offset % 50, 50, 50);
                break;
                
                case "Rectangle":
                  image(rectangle, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50) - sprite_window_offset % 50, 50, 50);
                break;
                
                case "Ellipse":
                  image(ellipse, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50) - sprite_window_offset % 50, 50, 50);
                break;
                  
                default:
                  image(no_icon, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50) - sprite_window_offset % 50, 50, 50);
                break;
              }
            } catch (Exception e){
              image(no_icon, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50) - sprite_window_offset % 50, 50, 50);
            }
            y_value++;
          }
          catch (Exception e){
            
          }
        }
      }
      else {
        for (int index = 0; index < sprites.size(); index++){
          noFill();
          rect(sprite_window_x, sprite_window_y + (y_value * 50), 300, sprite_element_height);
          textSize(25);
          fill(0);
          
          text(sprites.get(index).name, sprite_window_x + 25, sprite_window_y + (y_value * 50) + (sprite_element_height / 2));
          
          try {
            switch (sprites.get(index).type){
              case "Image":
                image(sprites.get(index).image, sprite_window_x + 275 + 1, sprite_window_y + 25 + (y_value * 50) + 1, 50 - 1, 50 - 1);
              break;
              
              case "Background":
                image(background_icon, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50), 50, 50);
              break;
              
              case "Rectangle":
                image(rectangle, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50), 50, 50);
              break;
              
              case "Ellipse":
                image(ellipse, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50), 50, 50);
              break;
                
              default:
                image(no_icon, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50), 50, 50);
              break;
            }
          } catch (Exception e){
            image(no_icon, sprite_window_x + 275, sprite_window_y + 25 + (y_value * 50), 50, 50);
          }
          y_value++;
        }
      }
      
      fill(background_color[0], background_color[1], background_color[2]);
      noStroke();
      rect(sprite_window_x, sprite_window_y - sprite_element_height - 1, sprite_window_width + 1, sprite_element_height);
      rect(sprite_window_x, sprite_window_y + sprite_window_height + 1, sprite_window_width + 1, sprite_element_height);
      
      //zoom indicator
      image(plus, zoom_x - 20, zoom_y);
      image(minus, zoom_x + zoom_width + 20 - 3, zoom_y);
      noFill();
      //stroke(50);
      stroke(255);
      strokeWeight(1);
      rect(zoom_x, zoom_y - 3, zoom_width - 3, 6);
      fill(0, 150, 255);
      noStroke();
      
      rect(zoom_x, zoom_y - 3, ((zoom_width + 1) / (zoom_levels.length - 1)) * zoom, 6);
      
      //settings button
      fill(255);
      stroke(200);
      strokeWeight(2);
      //rect(settings_x - 26, settings_y - 26, 52, 52);
      image(settings_icon, settings_x, settings_y);
      
      //timeline
      textAlign(CENTER, BOTTOM);
      textSize(20);
      noFill();
      strokeWeight(1);
      
      //zoom-----------------------
      
      int offset_dist = int((float(scroll) / zoom_levels[zoom]) * (float(timeline_width) / 15));
      
      for (int line = round(scroll / zoom_levels[zoom]); line < videoLength + 1; line++){
        
        if ((element_dist * line) - offset_dist >= 0 && (element_dist * line) - offset_dist <= timeline_width){
      
          //////////calculations/////////////////
          m = floor((((frame - 1) + (zoom_levels[zoom] * line)) / 3600) % 60);
          s = floor((((frame - 1) + (zoom_levels[zoom] * line)) / 60) % 60);
          f = ((frame - 1) + (zoom_levels[zoom] * line)) % 60;
          
          //minutes
          if (m == 0){
            ms = "00";
          }
          else{
            if (m > 9){
              ms = str(m);
            }
            else{
              ms = "0" + str(m);
            }
          }
          
          //seconds
          if (s == 0){
            ss = "00";
          }
          else{
            if (s > 9){
              ss = str(s);
            }
            else{
              ss = "0" + str(s);
            }
          }
          
          //frames
          if (f == 0){
            fs = "00";
          }
          else{
            if (f > 9){
              fs = str(f);
            }
            else{
              fs = "0" + str(f);
            }
          }
          
          ////////////////////////
        
          textAlign(CENTER, BOTTOM);
          textSize(20);
          
          noFill();
          stroke(200);
          strokeWeight(1);
          
          rect(timeline_x + (element_dist * line) - offset_dist, timeline_y, 0, timeline_height);
          fill(255);
          text(ms + ":" + ss + ":" + fs, timeline_x + (element_dist * line) - offset_dist, timeline_y - 5);
        }
        
      }
      
      ///////////zoom---------------------- // activate zoom
      
      //timeline
      textAlign(LEFT, CENTER);
      
      stroke(200);
      strokeWeight(4);
      noFill();
      rect(timeline_x, timeline_y, timeline_width, timeline_height);
      
      //draw playhead if in view
      stroke(150, 150, 255);
      strokeWeight(5);
      if (playhead_position >= scroll && playhead_position <= scroll + (zoom_levels[zoom] * 15)){
        line(timeline_x + ((float(timeline_width) / (zoom_levels[zoom] * 15)) * playhead_position) - offset_dist, timeline_y, timeline_x + ((float(timeline_width) / (zoom_levels[zoom] * 15)) * playhead_position) - offset_dist, timeline_y + timeline_height);
      }
      stroke(255);
      strokeWeight(2);
      
      //Show state lines
      noFill();
      strokeWeight(1);
      stroke(100);
      if (sprite_selected == true){
        for (int count = 0; count < textbox_offset.length; count++){
          line(timeline_x + 2, timeline_y + (float) (timeline_height / textbox_offset.length) * (0.5f + count) + 2, timeline_x + timeline_width - 4, timeline_y + (float) (timeline_height / textbox_offset.length) * (0.5f + count) + 2);
        }
      }
      
      //Show states on timeline
      fill(0, 255, 0);
      stroke(255);
      strokeWeight(1);
      if (sprite_selected == true){
        int it_state_index = 0;
        for (State state1 : sprites.get(sprite_selected_index).states){
          if (state1.frame >= scroll && state1.frame <= scroll + zoom_levels[zoom] * 15){
            if (sprites.get(sprite_selected_index).type == "Background"){
              
              for (int count = 0; count < textbox_offset.length; count++){
                rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + count) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
              }
            }
            else if (sprites.get(sprite_selected_index).type == "Image"){
              
              try {
                
                State previous_state = sprites.get(sprite_selected_index).states.get(it_state_index - 1);
                
                if (state1.x != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
                if (state1.y != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + 1) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
                if (state1.image_width != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + 2) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
                if (state1.image_height != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + 3) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
                if (state1.rotation != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + 4) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
                if (state1.visibility != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + 5) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
                if (state1.layer != -1){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + 6) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
                
              } catch (Exception e){
                
                for (int count = 0; count < textbox_offset.length; count++){
                  rect(timeline_x + (float) (state1.frame - scroll) * (timeline_width / (float) (zoom_levels[zoom] * 15)) - timeline_state_width / 2, timeline_y + 2 + (float) (timeline_height / textbox_offset.length) * (0.5f + count) - timeline_state_width / 2,  timeline_state_width, timeline_state_width);
                }
              }
            }
          }
          
          it_state_index++;
        }
      }
      
      //timeline scroll bar
      fill(50, 50, 50); //background
      stroke(125);
      strokeWeight(2);
      rect(scroll_bar_x, scroll_bar_y, scroll_bar_width, scroll_bar_height);
      
      //calculations
      try {
        scroll_width = int(float(zoom_levels[zoom] * 15) / float(videoLength) * float(scroll_bar_width));
        scroll_x = int(scroll_bar_x + (float(scroll) / videoLength) * scroll_bar_width);
      } catch (Exception e) {
        
      }
      
      fill(220);
      noStroke();
      rect(scroll_x, scroll_y, scroll_width, scroll_height);
      
      fill(200);
      strokeWeight(1);
      stroke(255);
      rect(sprite_settings_x, sprite_settings_y, sprite_settings_width, sprite_settings_height);
      
      if (sprite_selected == true){
        
        if (sprite_settings_selected == true){
          fill(160);
          noStroke();
          rect(sprite_settings_x + 2, sprite_settings_y + 2 + sprite_settings_element_height * sprite_settings_selected_index, sprite_settings_width - 2, sprite_settings_element_height - 2);
        }
        
        for (int i = 0; i < textbox_offset.length; i++){
          noFill();
          strokeWeight(1);
          stroke(255);
          
          line(sprite_settings_x, sprite_settings_y + ((i + 1) * sprite_settings_element_height), sprite_settings_x + sprite_settings_width, sprite_settings_y + ((i + 1) * sprite_settings_element_height));
        
          fill(background_color[0], background_color[1], background_color[2]);
          strokeWeight(1);
          stroke(255);
          
          rect(sprite_settings_x + textbox_offset[i] - textbox_width_offset, sprite_settings_y + (i + 0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3, textbox_width[i], sprite_settings_element_height / 2);   
          
          if (sprites.get(sprite_selected_index).type == "Background" && i == 0){
            rect(sprite_settings_x + textbox_offset[i] - textbox_width_offset + textbox_width[i] + 10, sprite_settings_y + (i + 0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3, textbox_width[i + 1], sprite_settings_element_height / 2);
            rect(sprite_settings_x + textbox_offset[i] - textbox_width_offset + textbox_width[i] + textbox_width[i + 1] + 20, sprite_settings_y + (i + 0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3, textbox_width[i + 2], sprite_settings_element_height / 2);
          }
          
          fill(255);
          noStroke();
          textSize(sprite_settings_element_height / 2);
          textAlign(LEFT, CENTER);
          
          text(texts[i], sprite_settings_x + 10, sprite_settings_y + ((i + 0.5f) * sprite_settings_element_height));
        }
        
        for (int count = 0; count < current_interval_types.length; count++){
          switch (current_interval_types[count]){
            case "linear":
              image(linear, sprite_settings_x + sprite_settings_width - 19, sprite_settings_y + (0.58f + count) * sprite_settings_element_height, 25, 25);
            break;
            
            case "ease_out":
              image(ease_out, sprite_settings_x + sprite_settings_width - 19, sprite_settings_y + (0.58f + count) * sprite_settings_element_height, 25, 25);
            break;
            
            case "ease_in":
              image(ease_in, sprite_settings_x + sprite_settings_width - 19, sprite_settings_y + (0.58f + count) * sprite_settings_element_height, 25, 25);
            break;
            
            case "integer":
              image(integer, sprite_settings_x + sprite_settings_width - 19, sprite_settings_y + (0.58f + count) * sprite_settings_element_height, 25, 25);
            break;
          }
        }
        
        if (sprites.get(sprite_selected_index).type == "Image"){
        
          text(current_x, sprite_settings_x + textbox_offset[0], sprite_settings_y + ((0 + 0.5f) * sprite_settings_element_height));
          text(current_y, sprite_settings_x + textbox_offset[1], sprite_settings_y + ((1 + 0.5f) * sprite_settings_element_height));
          text(current_width, sprite_settings_x + textbox_offset[2], sprite_settings_y + ((2 + 0.5f) * sprite_settings_element_height));
          text(current_height, sprite_settings_x + textbox_offset[3], sprite_settings_y + ((3 + 0.5f) * sprite_settings_element_height));
          
          if (sprite_settings_typing == true && sprite_settings_index == 4){
            text(floats[sprite_settings_index], sprite_settings_x + textbox_offset[4], sprite_settings_y + ((4 + 0.5f) * sprite_settings_element_height));
          }
          else {
            text(str(current_rotation), sprite_settings_x + textbox_offset[4], sprite_settings_y + ((4 + 0.5f) * sprite_settings_element_height));
          }
          if (sprite_settings_typing == true && sprite_settings_index == 5){
            text(floats[sprite_settings_index], sprite_settings_x + textbox_offset[5], sprite_settings_y + ((5 + 0.5f) * sprite_settings_element_height));
          }
          else {
            text(str(current_visibility), sprite_settings_x + textbox_offset[5], sprite_settings_y + ((5 + 0.5f) * sprite_settings_element_height));
          }
          
          text(current_layer, sprite_settings_x + textbox_offset[6], sprite_settings_y + ((6 + 0.5f) * sprite_settings_element_height));
        }
        else if (sprites.get(sprite_selected_index).type == "Background"){
          text(current_fill_color[0], sprite_settings_x + textbox_offset[0], sprite_settings_y + (0.5f) * sprite_settings_element_height);
          text(current_fill_color[1], sprite_settings_x + textbox_offset[0] + 10 + textbox_width[0], sprite_settings_y + (0.5f) * sprite_settings_element_height);
          text(current_fill_color[2], sprite_settings_x + textbox_offset[0] + 20 + textbox_width[0] + textbox_width[1], sprite_settings_y + (0.5f) * sprite_settings_element_height);
        }
      }
      
      //Add / Remove state
      image(green_plus, green_plus_x, green_plus_y, green_plus_width, green_plus_height);
      image(red_minus, red_minus_x, red_minus_y, red_minus_width, red_minus_height);
      
      //Play / Stop buttons
      image(play, play_button_x, play_button_y, play_stop_buttons_width, play_stop_buttons_width);
      image(stop, stop_button_x, stop_button_y, play_stop_buttons_width, play_stop_buttons_width);
      
      if (is_snap_pressed){
        image(snap_pressed, snap_button_x, snap_button_y);
      }
      else {
        image(snap_unpressed, snap_button_x, snap_button_y);
      }
      
      //Export button
      image(export, export_button_x, export_button_y);
      
      if (sprite_mode){
        image(eye_opened, sprite_mode_x, sprite_mode_y);
      }
      else {
        image(eye_closed, sprite_mode_x, sprite_mode_y);
      }
      
      //Instant update button
      //if (instant_update){
      //  image(updates_on, instant_updates_x, instant_updates_y);
      //}
      //else {
      //  image(updates_off, instant_updates_x, instant_updates_y);
      //}
      
      if (sprite_selected == true && sprites.get(sprite_selected_index).type != "Background"){
        //Element drag box
        fill(0, 255, 0);
        stroke(0);
        strokeWeight(1);
        
        try {
          rect(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) latest_x / 1920f) - timeline_state_width / 2, interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) latest_y / 1080f) - timeline_state_width / 2, timeline_state_width, timeline_state_width);
        } catch (Exception e){
          rect(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) current_x / 1920f) - timeline_state_width / 2, interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) current_y / 1080f) - timeline_state_width / 2, timeline_state_width, timeline_state_width);
        }
        
        //Element rotation box
        fill(0, 255, 0);
        stroke(0);
        strokeWeight(1);
        
        pushMatrix();
        
        try {
          translate(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) latest_x / 1920f), interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) latest_y / 1080f));
          rotate(radians(latest_rotation));
        } catch (Exception e){
          translate(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) current_x / 1920f), interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) current_y / 1080f));
          rotate(radians(current_rotation));
        }
        
        ellipse(0, -rotation_slider_distance, 10, 10);
        
        popMatrix();
      }
      
      //Show dropdown menus
      for (Dropdown_menu menu : dropdown_menus){
        menu.update_no_click(mouseX, mouseY);
        menu.show();
      }
      
      //Update sprite hovers
      if (isMouseOn(sprite_window_x, sprite_window_y, sprite_window_width, sprite_settings_element_height * sprites.size(), "CORNER")){
        sprite_hovered = true;
        sprite_hovered_index = floor((float) (mouseY - interface1.sprite_window_y + interface1.sprite_window_offset % interface1.sprite_element_height) / (float) interface1.sprite_element_height) + floor(interface1.sprite_window_offset / interface1.sprite_element_height);
      }
      else {
        sprite_hovered = false;
      }
      
      //Update mouse cursor textbox input icon
      if (sprite_selected == true && isMouseOn(sprite_settings_x, sprite_settings_y, sprite_settings_width, sprite_settings_height, "CORNER")){
        boolean mouseIsOn = false;
        
        if (sprites.get(sprite_selected_index).type == "Image"){
          for (int count = 0; count < textbox_offset.length; count++){
            if (isMouseOn((int) (sprite_settings_x + textbox_offset[count] - textbox_width_offset), (int) (sprite_settings_y + (count + 0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3), textbox_width[count], (int) (sprite_settings_element_height / 2), "CORNER")){
              if (cursor != "TEXT"){
                cursor(TEXT);
                cursor = "TEXT";
              }
              
              mouseIsOn = true;
              
              break;
            }
          }
        }
        else if (sprites.get(sprite_selected_index).type == "Background"){
          if (isMouseOn((int) (sprite_settings_x + textbox_offset[0] - textbox_width_offset), (int) (sprite_settings_y + (0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3), (int) (textbox_width[0]), (int) (sprite_settings_element_height / 2), "CORNER")){
            mouseIsOn = true;
          }
          else if (isMouseOn((int) (sprite_settings_x + textbox_offset[0] - textbox_width_offset + textbox_width[0] + 10), (int) (sprite_settings_y + (0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3), (int) (textbox_width[1]), (int) (sprite_settings_element_height / 2), "CORNER")){
            mouseIsOn = true;
          }
          else if (isMouseOn((int) (sprite_settings_x + textbox_offset[0] - textbox_width_offset + textbox_width[0] + textbox_width[1] + 20), (int) (sprite_settings_y + (0.5f) * sprite_settings_element_height - sprite_settings_element_height / 4 + 3), (int) (textbox_width[2]), (int) (sprite_settings_element_height / 2), "CORNER")){
            mouseIsOn = true;
          }
        }
        
        if (mouseIsOn == false){
          if (cursor != "ARROW"){
            cursor(ARROW);
            cursor = "ARROW";
          }
        }
        else {
          if (cursor != "TEXT"){
            cursor(TEXT);
            cursor = "TEXT";
          }
        }
        
        mouseIsOn = false;
      }
      else {
        if (cursor != "ARROW"){
          cursor(ARROW);
          cursor = "ARROW";
        }
      }
    }
    else if (mode == "Name_Sprite"){
      background(50);
      stroke(200);
      strokeWeight(2);
      fill(255);
      
      //textBox
      rect(tBox_x, tBox_y, tBox_width, tBox_height);
      fill(100);
      textSize(30);
      textAlign(LEFT, CENTER);
      text(currentName, tBox_x + 25, tBox_y + (tBox_height / 2));
      
      
      //Checkmark
      fill(255);
      rect(tBox_x + tBox_width + 50, tBox_y, 50, 50);
      image(check_mark, tBox_x + tBox_width + 75, tBox_y + 25);
      
      if (textBox_clicked == true){
        noStroke();
        fill(200);
        rect(tBox_x + 5, tBox_y + tBox_height + 5, tBox_width - 10, 2);
      }
    }
    else if (mode == "Options"){
      
      //video quality slider
      textAlign(RIGHT, CENTER);
      textSize(35);
      fill(255);
      text("Video quality", vqs_x - 70, (vqs_y * 2) - 5);
      
      if (video_quality_clicked == true){
        video_quality = ((vqs_width / 100) * (((mouseX - vqs_x) / 4)));
      }
      
      if (video_quality < 0){
        video_quality = 0;
      }
      else if (video_quality > 100){
        video_quality = 100;
      }
      
      fill(255);
      noStroke();
      rect(vqs_x, vqs_y, ((vqs_width / 100) * video_quality),vqs_height);
  
      noFill();
      stroke(200);
      strokeWeight(2);
      rect(vqs_x, vqs_y, vqs_width, vqs_height);
      
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(35);
      text(video_quality + "%", 535, 50 - 5);
      
      
      
      //framerate slider
      textAlign(RIGHT, CENTER);
      textSize(35);
      fill(255);
      text("Framerate", frs_x - 70, (frs_y + 25) - 5);
      
      if (framerate_clicked == true){
        framerate = (int) ((frs_width / 120) * (((mouseX - frs_x) / 4)));
        
        if (framerate <= 0){
          framerate = 1;
        }
      }
      
      if (framerate < 0){
        framerate = 0;
      }
      else if (framerate > 120){
        framerate = 120;
      }
      
      fill(255);
      noStroke();
      rect(frs_x, frs_y, ((frs_width / 120) * (framerate)),frs_height);
  
      noFill();
      stroke(200);
      strokeWeight(2);
      rect(frs_x, frs_y, frs_width, frs_height);
      
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(35);
      text(framerate + " fps", 575, (frs_y + 25) - 5);
      
      
      //settings button
      fill(255);
      stroke(200);
      strokeWeight(2);
      //rect(settings_x - 26, settings_y - 26, 52, 52);
      image(settings_icon, settings_x, settings_y);
      
    }
    else if (mode == "Export"){
      
    }
  }
}
