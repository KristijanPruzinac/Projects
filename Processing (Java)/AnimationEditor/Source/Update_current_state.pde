void updateCurrentState(){
  
  if (interface1.sprite_selected == true){
    int state_index = 0;
    
    for (state_index = 0; state_index < sprites.get(interface1.sprite_selected_index).states.size(); state_index++){
      if (sprites.get(interface1.sprite_selected_index).states.get(state_index).frame > interface1.playhead_position){
        state_index--;
        break;
      }
    }
    
    //state_index--;
    
    State last_state;
    
    if (sprites.get(interface1.sprite_selected_index).type == "Image"){
      
      //try {
      //  last_state = sprites.get(interface1.sprite_selected_index).states.get(state_index);
      //} catch (Exception e){
      //  last_state = sprites.get(interface1.sprite_selected_index).states.get(sprites.get(interface1.sprite_selected_index).states.size() - 1);
      //  //last_state = new State(0, 0, 0, 0, 0, 0, new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"}, 1, 1);
      //}
      
      last_state = new State(0, 0, 0, 0, 0, 0, new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"}, 1, 1);
      
      int last_x = 0;
      int last_y = 0;
      int last_width = 0;
      int last_height = 0;
      float last_rotation = 0;
      int last_layer = 0;
      float last_visibility = 0;
      String[] last_interval_types;
      
      last_x = last_x;
      last_y = last_state.y;
      last_width = last_state.image_width;
      last_height = last_state.image_height;
      last_rotation = last_state.rotation;
      last_layer = last_state.layer;
      last_visibility = last_state.visibility;
      last_interval_types = last_state.interval_types;
      
      //x
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.x != -1){
            last_x = state.x;
          }
        }
      }
      
      
      
      //y
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.y != -1){
            last_y = state.y;
          }
        }
      }
      
      //width
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.image_width != -1){
            last_width = state.image_width;
          }
        }
      }
      
      //height
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.image_height != -1){
            last_height = state.image_height;
          }
        }
      }
      
      //rotation
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.rotation != -1){
            last_rotation = state.rotation;
          }
        }
      }
      
      //layer
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.layer != -1){
            last_layer = state.layer;
          }
        }
      }
      
      //visibility
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.visibility != -1){
            last_visibility = state.visibility;
          }
        }
      }
      
      //interval_types
      for (State state : sprites.get(interface1.sprite_selected_index).states){
        if (state.frame > interface1.playhead_position){
          break;
        }
        else {
          if (state.interval_types != new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"}){
            last_interval_types = state.interval_types;
          }
        }
      }
      interface1.current_x = last_x;
      interface1.current_y = last_y;
      interface1.current_width = last_width;
      interface1.current_height = last_height;
      interface1.current_rotation = last_rotation;
      interface1.current_layer = last_layer;
      interface1.current_visibility = last_visibility;
      //interface1.current_interval_types = last_interval_types;
      interface1.current_interval_types = new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"};
      //interface1.current_fill_color = last_state.fill_color;
      
      floats = new String[7];
      
      for (int index = 0; index < floats.length; index++){
        floats[index] = "0.0";
      }
    
      if (sprites.get(interface1.sprite_selected_index).type != interface1.previous_type){
        
        interface1.previous_type = sprites.get(interface1.sprite_selected_index).type;
      
        interface1.textbox_width = new int[7];
        
        interface1.textbox_width[0] = 25;
        interface1.textbox_width[1] = 25;
        interface1.textbox_width[2] = 25;
        interface1.textbox_width[3] = 25;
        interface1.textbox_width[4] = 25;
        interface1.textbox_width[5] = 25;
        interface1.textbox_width[6] = 25;
        
        interface1.textbox_offset = new int[7];
        
        interface1.textbox_offset[0] = 150;
        interface1.textbox_offset[1] = 150;
        interface1.textbox_offset[2] = 200;
        interface1.textbox_offset[3] = 210;
        interface1.textbox_offset[4] = 225;
        interface1.textbox_offset[5] = 230;
        interface1.textbox_offset[6] = 190;
        
        interface1.texts = new String[7];
        interface1.texts[0] = "Position x";
        interface1.texts[1] = "Position y";
        interface1.texts[2] = "Element width";
        interface1.texts[3] = "Element height";
        interface1.texts[4] = "Element rotation";
        interface1.texts[5] = "Element visibility";
        interface1.texts[6] = "Element layer";
      }
      
      if (sprites.get(interface1.sprite_selected_index).states.size() > 1) {
        interface1.latest_x = sprites.get(interface1.sprite_selected_index).states_final[interface1.playhead_position].x;
        interface1.latest_y = sprites.get(interface1.sprite_selected_index).states_final[interface1.playhead_position].y;
        interface1.latest_rotation = sprites.get(interface1.sprite_selected_index).states_final[interface1.playhead_position].rotation;
      }
      else {
        interface1.latest_x = interface1.current_x;
        interface1.latest_y = interface1.current_y;
        interface1.latest_rotation = interface1.current_rotation;
      }
    }
    else if (sprites.get(interface1.sprite_selected_index).type == "Background"){
        
      try {
        last_state = sprites.get(interface1.sprite_selected_index).states.get(state_index);
      } catch (Exception e){
        last_state = new State(0, new String[]{"linear"}, new int[]{255, 255, 255}, 9);
      }
      
      interface1.current_layer = last_state.layer;
      interface1.current_interval_types = last_state.interval_types;
      interface1.current_fill_color = last_state.fill_color;
    
      if (sprites.get(interface1.sprite_selected_index).type != interface1.previous_type){
        
        interface1.previous_type = sprites.get(interface1.sprite_selected_index).type;
      
        interface1.textbox_width = new int[3];
        
        interface1.textbox_width[0] = 25;
        interface1.textbox_width[1] = 25;
        interface1.textbox_width[2] = 25;
        
        interface1.textbox_offset = new int[1]; 
        interface1.textbox_offset[0] = 95;
        
        interface1.texts = new String[1];
        interface1.texts[0] = "Color";
        
        interface1.current_fill_color = new int[3];
        interface1.current_fill_color[0] = 255;
        interface1.current_fill_color[1] = 255;
        interface1.current_fill_color[2] = 255;
      }
    }
    
    //for (Sprite sprite : sprites){
    //  sprite.update();
    //}
  }
  
  interface1.last_frame = 0;
  
  for (Sprite sprite : sprites){
    for (State state: sprite.states){
      if (state.frame > interface1.last_frame){
        interface1.last_frame = state.frame;
      }
    }
  }
}
