class Interface {
  String function = "";
  
  float zoom = 1;
  
  int value_count = 8;
  
  float step = 0.25;
  
  int pointer_count = 0;
  
  int pointer_index = 0;
  
  float[] letter_distances;
  
  Point[] points = new Point[int((float) (value_count * 2) / step)];
  
  void update(){
    points = new Point[int((float) (value_count * 2) / step) + 1];
    
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
  
  void show(){
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
    for (int count = 1; count < float(value_count) * zoom + 1; count++){
      ellipse((width / 2) + ((float(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2, scaleY(8), scaleY(8));
      
      text(rz(float(count) / zoom), (width / 2) + ((float(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2 + scaleY(10));
    }
    for (int count = 1; count < float(value_count) * zoom + 1; count++){
      ellipse((width / 2) - ((float(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2, scaleY(8), scaleY(8));
      
      text("-" + rz(float(count) / zoom), (width / 2) - ((float(line_length) / 4) / (value_count * zoom)) * zoom * count, height / 2 + scaleY(10));
    }
    
    textAlign(RIGHT, CENTER);
    
    for (int count = 1; count < float(value_count) * zoom + 1; count++){
      ellipse(width / 2, (height / 2) - ((float(line_length) / 4) / (value_count * zoom)) * zoom * count, scaleY(8), scaleY(8));
      
      text(rz(float(count) / zoom), width / 2 - scaleX(10), (height / 2) - ((float(line_length) / 4) / (value_count * zoom)) * zoom * count);
    }
    for (int count = 1; count < float(value_count) * zoom + 1; count++){
      ellipse(width / 2, (height / 2) + ((float(line_length) / 4) / (value_count * zoom)) * zoom * count, scaleY(8), scaleY(8));
      
      text("-" + rz(float(count) / zoom), width / 2 - scaleX(10), (height / 2) + ((float(line_length) / 4) / (value_count * zoom)) * zoom * count);
    }
    
    //show Function
    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    
    try {
      for (int count = 0; count < points.length; count++){
        if (count > int(points.length) / 2){
          if ((float) scaleY(points[count + 1].y) * ((float) (line_length / 4) / (float) value_count) > (float) (line_length / 4) || (float) scaleY(points[count + 1].y) * ((float) (line_length / 4) / (float) value_count) < (float) -(line_length / 4)){
            break;
          }
        }
        if ((float) scaleY(points[count].y) * ((float) (line_length / 4) / (float) value_count) >= -(float) (line_length / 4) && (float) scaleY(points[count].y) * ((float) (line_length / 4) / (float) value_count) <= (float) (line_length / 4)){
          line(int(width / 2) + (float) scaleX(points[count].x) * ((float) (line_length / 4) / (float) value_count) * (float) zoom, int(height / 2) - (float) scaleY(points[count].y) * ((float) (line_length / 4) / (float) value_count) * (float) zoom, int(width / 2) + (float) scaleX(points[count + 1].x) * ((float) (line_length / 4) / (float) value_count) * (float) zoom, (height / 2) - (float) scaleY(points[count + 1].y) * ((float) (line_length / 4) / (float) value_count) * (float) zoom);
        }
      }
    } catch (Exception e){
      
    }
  }
}
