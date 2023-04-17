void updateTextboxWidths(){
  if (sprites.get(interface1.sprite_selected_index).type == "Image"){
    interface1.textbox_width[0] = int(textWidth(str(interface1.current_x))) + 2 * interface1.textbox_width_offset;
    interface1.textbox_width[1] = int(textWidth(str(interface1.current_y))) + 2 * interface1.textbox_width_offset;
    interface1.textbox_width[2] = int(textWidth(str(interface1.current_width))) + 2 * interface1.textbox_width_offset;
    interface1.textbox_width[3] = int(textWidth(str(interface1.current_height))) + 2 * interface1.textbox_width_offset;
    
    if (sprite_settings_typing == true && sprite_settings_index == 4){
      interface1.textbox_width[4] = int(textWidth(floats[sprite_settings_index])) + 2 * interface1.textbox_width_offset;
    }
    else {
      interface1.textbox_width[4] = int(textWidth(str(interface1.current_rotation))) + 2 * interface1.textbox_width_offset;
    }
    
    if (sprite_settings_typing == true && sprite_settings_index == 5){
      interface1.textbox_width[5] = int(textWidth(floats[sprite_settings_index])) + 2 * interface1.textbox_width_offset;
    }
    else {
      interface1.textbox_width[5] = int(textWidth(str(interface1.current_visibility))) + 2 * interface1.textbox_width_offset;
    }
    interface1.textbox_width[6] = int(textWidth(str(interface1.current_layer))) + 2 * interface1.textbox_width_offset;
  }
  else if (sprites.get(interface1.sprite_selected_index).type == "Background"){
    interface1.textbox_width[0] = int(textWidth(str(interface1.current_fill_color[0]))) + 2 * interface1.textbox_width_offset;
    interface1.textbox_width[1] = int(textWidth(str(interface1.current_fill_color[1]))) + 2 * interface1.textbox_width_offset;
    interface1.textbox_width[2] = int(textWidth(str(interface1.current_fill_color[2]))) + 2 * interface1.textbox_width_offset;
  }
}
