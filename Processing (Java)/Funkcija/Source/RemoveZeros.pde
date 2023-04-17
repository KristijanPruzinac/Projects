String rz(float number){
  String return_val;
  
  if (number % 1 == 0){
    return_val = str(int(number));
  }
  else if (number % 0.5 == 0){
    return_val = str(int(number * 10) / float(10));
  }
  else {
    return_val = str(int(number * 100) / float(100));
  }
  
  return return_val;
}
