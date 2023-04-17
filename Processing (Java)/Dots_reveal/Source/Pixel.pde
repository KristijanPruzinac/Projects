class Pixel {
  float x;
  float y;
  
  float real_x;
  float real_y;
  
  int target_x;
  int target_y;
  
  float offset_x;
  float offset_y;
  
  boolean in_range = false;
  
  int[] pixel_color;
  
  Pixel(int target_x, int target_y, int[] pixel_color){
    
    this.target_x = target_x;
    this.target_y = target_y;
    
    this.pixel_color = pixel_color;
    
    offset_y = random(-reveal_area, reveal_area);
    
    offset_x = random(-1, 1) * cos(asin(offset_y / reveal_area)) * reveal_area;
    
    y = mouseY + offset_y * 3;
    x = mouseX + offset_x * 3;
    
    real_x = x;
    real_y = y;
  }
  
  void update(){
    if (away){
      in_range = false;
      
      real_x += (mouseX + offset_x - real_x) / abs(mouseX + offset_x - real_x) * random(1, dots_max_speed * 2) * (abs(mouseX + offset_x - real_x) * 0.05);
      real_y += (mouseY + offset_y - real_y) / abs(mouseY + offset_y - real_y) * random(1, dots_max_speed * 2) * (abs(mouseY + offset_y - real_y) * 0.05);
    
      x = real_x;
      y = real_y;
    }
    else {
      if (sqrt(pow(target_x - mouseX, 2) + pow(target_y - mouseY, 2)) <= reveal_area){
        in_range = true;
        
        x += (target_x - x) / abs(target_x - x) * random(0.5, dots_max_speed) * (abs(target_x - x) * 0.05);
        y += (target_y - y) / abs(target_y - y) * random(0.5, dots_max_speed) * (abs(target_y - y) * 0.05);
        
        real_x = x;
        real_y = y;
      }
      else {
        in_range = false;
        
        real_x += (mouseX + offset_x - real_x) / abs(mouseX + offset_x - real_x) * random(0.5, dots_max_speed) * (abs(mouseX + offset_x - real_x) * 0.05);
        real_y += (mouseY + offset_y - real_y) / abs(mouseY + offset_y - real_y) * random(0.5, dots_max_speed) * (abs(mouseY + offset_y - real_y) * 0.05);
        
        x = real_x;
        y = real_y;
      }
    }
  }
  
  void show(){
    fill(pixel_color[0], pixel_color[1], pixel_color[2]);
    noStroke();
    rect(round(x), round(y), 1, 1);
  }
}
