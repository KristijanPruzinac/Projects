class Final_state {
  int x;
  int y;
  
  float rotation;
  
  int image_width;
  int image_height;
  
  float visibility;
  
  int layer;
  
  int[] fill_color;
  
  Final_state (int[] fill_color, int layer){
    this.fill_color = fill_color;
    this.layer = layer;
  }
  
  Final_state (int x, int y, float rotation, int image_width, int image_height, int layer, float visibility){
    this.x = x;
    this.y = y;
    this.rotation = rotation;
    this.layer = layer;
    this.visibility = visibility;
    this.image_width = image_width;
    this.image_height = image_height;
  }
}
