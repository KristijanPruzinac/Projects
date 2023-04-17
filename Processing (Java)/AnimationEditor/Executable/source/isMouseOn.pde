Boolean isMouseOn(int p1, int p2, int p3, int p4, String mode){
  p1 = (int) (p1 * scalex);
  p2 = (int) (p2 * scaley);
  p3 = (int) (p3 * scalex);
  p4 = (int) (p4 * scaley);
  
  Boolean return_val = false;
  if (mode == "CORNERS"){
    if (mouseX > p1 && mouseX < p3 && mouseY > p2 && mouseY < p4){
      return_val = true;
    }
  }
  else if (mode == "CORNER"){
    if (mouseX > p1 && mouseX < p1 + p3 && mouseY > p2 && mouseY < p2 + p4){
      return_val = true;
    }
  }
  return return_val;
}
