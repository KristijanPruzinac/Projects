class Dropdown_menu {
  int x;
  int y;

  int dwidth;
  int dheight;
  
  String text;

  String[] options;
  
  int selected_element;
  
  int hovered_element;
  
  boolean mouse_hovered = false;

  boolean pressed = false;

  //Options
  boolean fill_on = true;
  boolean stroke_on = true;

  int[] Fill_color = {200, 200, 200};
  int[] Stroke_color = {255, 255, 255};
  int[] Hovered_color = {150, 150, 255};

  Dropdown_menu (String text, int x, int y, int dwidth, int dheight, String[] options) {
    this.text = text;
    this.x = x;
    this.y = y;
    this.dwidth = dwidth;
    this.dheight = dheight;
    this.options = options;
  }

  void update(int mousex, int mousey) {
    if (isMouseOn(x, y, dwidth, dheight, "CORNER")) {
      if (pressed == false) {
        pressed = true;
      } else {
        pressed = false;
      }
    }
    else if (isMouseOn(x, y + dheight, dwidth, dheight * (options.length), "CORNER") && pressed == true){
      selected_element = int(floor(((float) mousey - ((float) y + (float) dheight)) / (float) dheight));
      
      if (options[selected_element] == "Image"){
        open_file();
      }
      else {
        sprites.add(new Sprite(options[selected_element], null));
        interface1.mode = "Name_Sprite";
        interface1.currentName = "";
        interface1.name_length = 0;
      }
      
      pressed = false;
    }
  }
  
  void update_no_click(int mousex, int mousey) {
    if (mousex > x && mousex < x + dwidth && mousey > y + dheight && mousey < y + dheight * (1 + options.length)){
      mouse_hovered = true;
      
      hovered_element = int(floor(((float) mousey - ((float) y + (float) dheight)) / (float) dheight));
    }
    else {
      mouse_hovered = false;
    }
  }

  void show() {
    
    if (fill_on == true) {
      fill(Fill_color[0], Fill_color[1], Fill_color[2]);
    } else {
      noFill();
    }

    if (stroke_on == true) {
      stroke(Stroke_color[0], Stroke_color[1], Stroke_color[2]);
      strokeWeight(1);
    } else {
      noStroke();
    }

    if (pressed == false) {
      rectMode(CORNER);
      rect(x, y, dwidth, dheight);
      
      textAlign(CENTER, CENTER);
      textSize(int(dheight * 0.5f));
      
      fill(255);
      stroke(255);
      strokeWeight(1);
      
      text(text, x, y, dwidth, dheight);
      
    } else {
      rectMode(CORNER);
      rect(x, y, dwidth, dheight);
      rect(x, y + dheight, dwidth, dheight * options.length);
      
      if (mouse_hovered == true){
        noStroke();
        fill(Hovered_color[0], Hovered_color[1], Hovered_color[2]);
        rect(x + 1, y + dheight * (hovered_element + 1) + 1, dwidth - 2, dheight - 2);
      }

      fill(255);
      stroke(255);
      strokeWeight(1);

      for (int line_num = 0; line_num < options.length; line_num++) {
        line(x, y + dheight * (2 + line_num), x + dwidth, y + dheight * (2 + line_num));
      }
      
      textAlign(CENTER, CENTER);
      textSize(int(dheight * 0.5f));
      
      text(text, x, y, dwidth, dheight);
      
      //textAlign(LEFT, CENTER);
      //textSize(int(dheight * 0.5f));

      //for (int line_num = 0; line_num < options.length; line_num++) {
      //  text(options[line_num], x + 10, y + dheight * (2 + line_num) - dheight / 2);
      //}
      
      for (int line_num = 0; line_num < options.length; line_num++) {
        text(options[line_num], x, y + dheight * (1 + line_num), dwidth, dheight);
      }
    }
  }
}
