// Class for making animations
class Animation {
  ArrayList<Float> values = new ArrayList<Float>();
  ArrayList<Float> updates = new ArrayList<Float>();
  
  ArrayList<String> names = new ArrayList<String>();
  ArrayList<String> types = new ArrayList<String>();
  ArrayList<Integer> states = new ArrayList<Integer>();
  
  void update(){
    for (int count = 0; count < names.size(); count++){
      values.set(count, values.get(count) + updates.get(count));
      
      //Never go over 1
      if (values.get(count) > 1){
        values.set(count, 1f);
      }
    }
  }
  
  void addAnimation(String animation_name, String type, float time, int state){
    if (type == "Integer"){
      names.add(animation_name);
      values.add(1f);
      updates.add(0f);
      types.add(type);
      states.add(state);
    }
    else {
      names.add(animation_name);
      values.add(0f);
      updates.add(1 / (((float) time / 1000) * frameRate));
      types.add(type);
      states.add(state);
    }
  }
  
  void reset(){
    values.clear();
    updates.clear();
    names.clear();
    types.clear();
    states.clear();
  }
  
  void removeAnimation(String name){
    int temp_index = names.indexOf(name);
    
    values.remove(temp_index);
    updates.remove(temp_index);
    names.remove(temp_index);
    types.remove(temp_index);
    states.remove(temp_index);
  }
  
  boolean isFinished(String name){
    int temp_index = names.indexOf(name);
    
    if (values.get(temp_index) >= 1){
      return true;
    }
    else {
      return false;
    }
  }
  
  void changeState(String animation_name, String type, float time, int state){
    int temp_index = names.indexOf(animation_name);
    
    values.set(temp_index, 0f);
    updates.set(temp_index, 1 / (((float) time / 1000) * frameRate));
    types.set(temp_index, type);
    states.set(temp_index, state);
  }
  
  int getState(String name){
    int temp_index = names.indexOf(name);
    
    return states.get(temp_index);
  }
  
  float getValue(String name){
    int temp_index = names.indexOf(name);
    
    float return_value = 0;
    
    switch(types.get(temp_index)){
      case "linear":
        return_value = values.get(temp_index);
      break;
      
      case "ease_in":
        return_value = 1 - cos((values.get(temp_index) / 2) * PI);
      break;
      
      case "ease_out":
        return_value = sin((values.get(temp_index) / 2) * PI);
      break;
      
      case "integer":
        return_value = 1;
      break;
      
      default:
        println("ERROR: Wrong animation type!");
      break;
    }
    
    return return_value;
  }
}
