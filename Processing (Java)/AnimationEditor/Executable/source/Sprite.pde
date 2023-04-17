class Sprite{
  PImage image;
  
  int id;
  
  String name;
  
  String type;
  
  ArrayList<State> states = new ArrayList<State>();
  Final_state[] states_final = new Final_state[interface1.videoLength];
  
  //Image
  Sprite(String type, PImage image){
    this.type = type;
    this.image = image;
    this.id = id_assign;
    id_assign++;
    
    states.add(new State(0, 0, 0, 0, 0, 0, new String[]{"linear", "linear", "linear", "linear", "linear", "linear", "integer"}, 1, 1));
    
    //for (int count = 0; count < states_final.length; count++){
    //  states_final[count] = new Final_state(type, 0, 0, 0, 0, 0, 1, 1);
    //}
  }
 
  Sprite(String type){
    this.type = type;
    this.id = id_assign;
    id_assign++;
    
    //Background
    if (type == "Background"){
      states.add(new State(0, new String[]{"linear"}, new int[]{255, 255, 255}, 9));
    }
    
    //Ellipse / Rect
    else {
      states.add(new State(0, 0, 0, 0, 0, 0, new String[]{"linear", "linear", "linear", "linear", "linear", "integer", "linear", "linear", "linear", "linear", "integer", "integer"}, 1, 1, new int[]{0, 0, 0}, new int[]{0, 0, 0}, 1, true, true));
    }
  }
  
  void update(){
    Animation animator = new Animation();
    
    states_final = new Final_state[interface1.videoLength];
    
    if (type == "Background"){
      for (int count = 0; count < states.size() - 1; count++){
        
        animator.reset();
        
        animator.addAnimation("red", states.get(count + 1).interval_types[0], (states.get(count + 1).frame - states.get(count).frame) / frameRate * 1000f, 1);
        animator.addAnimation("green", states.get(count + 1).interval_types[0], (states.get(count + 1).frame - states.get(count).frame) / frameRate * 1000f, 1);
        animator.addAnimation("blue", states.get(count + 1).interval_types[0], (states.get(count + 1).frame - states.get(count).frame) / frameRate * 1000f, 1);
        
        if (count != states.size() - 2){
          for (int frame = states.get(count).frame; frame < states.get(count + 1).frame; frame++){
            states_final[frame] = new Final_state(new int[]{int(states.get(count).fill_color[0] + (float) animator.getValue("red") * (float) (states.get(count + 1).fill_color[0] - states.get(count).fill_color[0])),
                                                            int(states.get(count).fill_color[1] + (float) animator.getValue("green") * (float) (states.get(count + 1).fill_color[1] - states.get(count).fill_color[1])),
                                                            int(states.get(count).fill_color[2] + (float) animator.getValue("blue") * (float) (states.get(count + 1).fill_color[2] - states.get(count).fill_color[2]))}, 9);
  
            animator.update();
          }
        }
        else {
          for (int frame = states.get(count).frame; frame <= states.get(count + 1).frame; frame++){
            states_final[frame] = new Final_state(new int[]{int(states.get(count).fill_color[0] + (float) animator.getValue("red") * (float) (states.get(count + 1).fill_color[0] - states.get(count).fill_color[0])),
                                                            int(states.get(count).fill_color[1] + (float) animator.getValue("green") * (float) (states.get(count + 1).fill_color[1] - states.get(count).fill_color[1])),
                                                            int(states.get(count).fill_color[2] + (float) animator.getValue("blue") * (float) (states.get(count + 1).fill_color[2] - states.get(count).fill_color[2]))}, 9);
  
            animator.update();
          }
        }
      }
    }
    else if (type == "Image"){
      
      for (int frame = 0; frame < states_final.length; frame++){
        states_final[frame] = new Final_state(0, 0, 0, 0, 0, 0, 0);
      }
      
      ArrayList<Integer> mask;
      
      //X position
      mask = new ArrayList<Integer>();
      
      ArrayList<Integer> values = new ArrayList<Integer>();
      
      ArrayList<Integer> indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).x != -1){
          mask.add(states.get(i).frame);
          values.add(states.get(i).x);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
        animator.addAnimation("animation", states.get(indexes.get(mask_index + 1)).interval_types[0], (float) (mask.get(mask_index + 1) - mask.get(mask_index)) / frameRate * 1000f, 1);
        
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          animator.update();
          
          states_final[frame].x = (int) (states.get(indexes.get(mask_index)).x + (float) (states.get(indexes.get(mask_index + 1)).x - states.get(indexes.get(mask_index)).x) * animator.getValue("animation"));
        }
        
        animator.reset();
      }
      
      if (states.get(states.size() - 1).frame < interface1.videoLength - 1){
        for (int index = states.get(states.size() - 1).frame; index < states.get(states.size() - 1).frame + 1; index++){
          try {
            states_final[index] = states_final[states.get(states.size() - 1).frame - 1];
          } catch (Exception e){
            break;
          }
        }
      }
      
      //Y position
      mask = new ArrayList<Integer>();
      
      indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).y != -1){
          mask.add(states.get(i).frame);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
        animator.addAnimation("animation", states.get(indexes.get(mask_index + 1)).interval_types[1], (float) (mask.get(mask_index + 1) - mask.get(mask_index)) / frameRate * 1000f, 1);
        
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          animator.update();
          
          states_final[frame].y = (int) (states.get(indexes.get(mask_index)).y + (float) (states.get(indexes.get(mask_index + 1)).y - states.get(indexes.get(mask_index)).y) * animator.getValue("animation"));
        }
        
        animator.reset();
      }
      
      //Rotation
      mask = new ArrayList<Integer>();
      
      indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).rotation != -1){
          mask.add(states.get(i).frame);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
        animator.addAnimation("animation", states.get(indexes.get(mask_index + 1)).interval_types[4], (float) (mask.get(mask_index + 1) - mask.get(mask_index)) / frameRate * 1000f, 1);
        
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          animator.update();
          
          states_final[frame].rotation = (states.get(indexes.get(mask_index)).rotation + (float) (states.get(indexes.get(mask_index + 1)).rotation - states.get(indexes.get(mask_index)).rotation) * animator.getValue("animation"));
        }
        
        animator.reset();
      }
      
      //Image width
      mask = new ArrayList<Integer>();
      
      indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).image_width != -1){
          mask.add(states.get(i).frame);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
        animator.addAnimation("animation", states.get(indexes.get(mask_index + 1)).interval_types[2], (float) (mask.get(mask_index + 1) - mask.get(mask_index)) / frameRate * 1000f, 1);
        
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          animator.update();
          
          states_final[frame].image_width = (int) (states.get(indexes.get(mask_index)).image_width + (float) (states.get(indexes.get(mask_index + 1)).image_width - states.get(indexes.get(mask_index)).image_width) * animator.getValue("animation"));
        }
        
        animator.reset();
      }
      
      //Image height
      mask = new ArrayList<Integer>();
      
      indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).image_height != -1){
          mask.add(states.get(i).frame);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
        animator.addAnimation("animation", states.get(indexes.get(mask_index + 1)).interval_types[3], (float) (mask.get(mask_index + 1) - mask.get(mask_index)) / frameRate * 1000f, 1);
        
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          animator.update();
          
          states_final[frame].image_height = (int) (states.get(indexes.get(mask_index)).image_height + (float) (states.get(indexes.get(mask_index + 1)).image_height - states.get(indexes.get(mask_index)).image_height) * animator.getValue("animation"));
        }
        
        animator.reset();
      }
      
      //Layer
      mask = new ArrayList<Integer>();
      
      indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).layer != -1){
          mask.add(states.get(i).frame);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
     
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          states_final[frame].layer = states.get(indexes.get(mask_index)).layer;
        }
      }
      
      //Visibility
      mask = new ArrayList<Integer>();
      
      indexes = new ArrayList<Integer>();
      
      for (int i = 0; i < states.size(); i++){
        if (states.get(i).visibility != -1){
          mask.add(states.get(i).frame);
          indexes.add(i);
        }
      }
      
      for (int mask_index = 0; mask_index < mask.size() - 1; mask_index++){
        animator.addAnimation("animation", states.get(indexes.get(mask_index + 1)).interval_types[5], (float) (mask.get(mask_index + 1) - mask.get(mask_index)) / frameRate * 1000f, 1);
        
        for (int frame = mask.get(mask_index); frame < mask.get(mask_index + 1); frame++){
          animator.update();
          
          states_final[frame].visibility = (states.get(indexes.get(mask_index)).visibility + (float) (states.get(indexes.get(mask_index + 1)).visibility - states.get(indexes.get(mask_index)).visibility) * animator.getValue("animation"));
        }
        
        animator.reset();
      }
    }
  }
  
  void showPreview(int layer, int index){
    
    if (states_final[interface1.playhead_position] != null){
      //if (type == "Image"){
      //println(type + " " + states_final[interface1.playhead_position].layer + " " + layer);
      //}
      
      if (states_final[interface1.playhead_position].layer == layer){
        
        if (type == "Background"){
          fill(states_final[interface1.playhead_position].fill_color[0], states_final[interface1.playhead_position].fill_color[1], states_final[interface1.playhead_position].fill_color[2]);
          rect(interface1.animation_window_x - 1, interface1.animation_window_y - 1, interface1.animation_window_width + 1, interface1.animation_window_height + 1);
        }
        else if (type == "Image"){
          pushMatrix();
          translate(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) states_final[interface1.playhead_position].x / 1920f), interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) states_final[interface1.playhead_position].y / 1080f));
          rotate(radians(states_final[interface1.playhead_position].rotation));
          tint(255, (float) 255 * states_final[interface1.playhead_position].visibility);
          image(image, 0, 0, (float) interface1.animation_window_width * (states_final[interface1.playhead_position].image_width / 1920f), (float) interface1.animation_window_height * (states_final[interface1.playhead_position].image_height / 1080f));
          tint(255, 255);
          //rotate(-radians(states_final[interface1.playhead_position].rotation));
          //translate(-(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) states_final[interface1.playhead_position].x / 1920f)), -(interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) states_final[interface1.playhead_position].y / 1080f)));
          popMatrix();
        }
      }
    }
    else if (type == "Background" && layer == 9){
      fill(255);
      noStroke();
      rect(interface1.animation_window_x, interface1.animation_window_y, interface1.animation_window_width, interface1.animation_window_height);
    }
  }
  
  void show(int layer, int index){
    
    if (states_final[interface1.playhead_position] != null){
      if (states_final[interface1.playhead_position].layer == layer){
        if (type == "Background"){
          fill(states_final[interface1.playhead_position].fill_color[0], states_final[interface1.playhead_position].fill_color[1], states_final[interface1.playhead_position].fill_color[2]);
          rect(0, 0, 1920, 1080);
        }
        else if (type == "Image"){
          pushMatrix();
          translate(states_final[interface1.playhead_position].x, states_final[interface1.playhead_position].y);
          rotate(radians(states_final[interface1.playhead_position].rotation));
          tint(255, (float) 255 * states_final[interface1.playhead_position].visibility);
          image(sprites.get(index).image, 0, 0, states_final[interface1.playhead_position].image_width, states_final[interface1.playhead_position].image_height);
          tint(255, 255);
          //rotate(-radians(states_final[interface1.playhead_position].rotation));
          //translate(-(interface1.animation_window_x + (float) (interface1.animation_window_width) * ((float) states_final[interface1.playhead_position].x / 1920f)), -(interface1.animation_window_y + (float) (interface1.animation_window_height) * ((float) states_final[interface1.playhead_position].y / 1080f)));
          popMatrix();
        }
      }
    }
    else if (type == "Background" && layer == 9){
      fill(255);
      noStroke();
      rect(0, 0, 1920, 1080);
    }
  }
}
