float angle = 0;

float scale = 1200;

float camera_distance = 700;

int number_of_cubes = 15;

String scroll_mode = "Roughness"; // "Number_of_cubes"

void setup(){
  fullScreen(P3D);
  lights();
  
  rectMode(CENTER);
}

float steadiness = 1.5;

void keyPressed(){
  if (key == 'q'){
    if (scroll_mode == "Roughness"){
      scroll_mode = "Number_of_cubes";
    }
    else {
      scroll_mode = "Roughness";
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
  if (scroll_mode == "Roughness"){
    if (e > 0){
      if (steadiness > 1){
        steadiness -= 0.1;
      }
    }
    else if (e < 0){
      if (steadiness < 5){
        steadiness += 0.1;
      }
    }
  }
  else if (scroll_mode == "Number_of_cubes"){
    if (e > 0){
      if (number_of_cubes > 10){
        number_of_cubes -= 1;
      }
    }
    else if (e < 0){
      if (number_of_cubes < 50){
        number_of_cubes += 1;
      }
    }
  }
}

void draw(){
  background(210);
  angle -= 0.1;
  
  directionalLight(255, 244, 242, -radians(45), radians(50), 0);
  
  translate(width / 2, height / 2, -camera_distance);
  
  rotateY(radians(45));
  
  rotateX(-radians(20));
  
  rotateZ(-radians(19));
  
  translate(-scale / 2, 0, -scale / 2);
  
  for (int row = 1; row <= number_of_cubes; row++){
    for (int column = 1; column <= number_of_cubes; column++){
      float dist_x = abs(column - (float) number_of_cubes / 2f);
      float dist_y = abs(row - (float) number_of_cubes / 2f);
      
      float dist = sqrt(pow(dist_x, 2) + pow(dist_y, 2));
      
      fill(230);
      noStroke();
      
      translate(row * (scale / number_of_cubes), 0, column * (scale / number_of_cubes));
      
      box((scale / number_of_cubes), 80 * map(sin(angle + dist / steadiness), -1, 1, 1, 5), (scale / number_of_cubes));
      
      translate(-row * (scale / number_of_cubes), 0, -column * (scale / number_of_cubes));
    }
  }
  
  translate(scale / 2, 0, scale / 2);
  
  rotateZ(radians(19));
  
  rotateX(radians(20));
  
  rotateY(-radians(45));
  
  translate(-width / 2, -height / 2, camera_distance);
}
