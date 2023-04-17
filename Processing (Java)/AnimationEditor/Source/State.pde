class State {
  int x;
  int y;
  
  float rotation;
  
  String[] interval_types;
  
  int image_width;
  int image_height;
  
  float visibility;
  
  int layer;
  
  int frame;
  
  boolean fill;
  boolean stroke;
  
  int[] fill_color;
  int[] stroke_color;
  
  int stroke_weight;
  
  State (int frame, int x, int y, float rotation, int image_width, int image_height, String[] interval_types, int layer, float visibility){
    this.frame = frame;
    this.x = x;
    this.y = y;
    this.rotation = rotation;
    this.interval_types = interval_types;
    this.layer = layer;
    this.visibility = visibility;
    this.image_width = image_width;
    this.image_height = image_height;
  }
  
  State (int frame, String[] interval_types, int[] fill_color, int layer){
    this.frame = frame;
    this.interval_types = interval_types;
    this.fill_color = fill_color;
    this.layer = layer;
  }
  
  State (int frame, int x, int y, float rotation, int image_width, int image_height, String[] interval_types, int layer, float visibility, int[] fill_color, int[] stroke_color, int stroke_weight, boolean fill, boolean stroke){
    this.frame = frame;
    this.x = x;
    this.y = y;
    this.rotation = rotation;
    this.interval_types = interval_types;
    this.layer = layer;
    this.visibility = visibility;
    this.image_width = image_width;
    this.image_height = image_height;
    this.fill_color = fill_color;
    this.stroke_color = stroke_color;
    this.stroke_weight = stroke_weight;
    this.fill = fill;
    this.stroke = stroke;
  }
}
