String switchInterval(String current_interval){
  ArrayList<String> intervals = new ArrayList<String>();
  intervals.add("linear");
  intervals.add("ease_in");
  intervals.add("ease_out");
  intervals.add("integer");
  
  int current_interval_num = intervals.indexOf(current_interval);
  
  current_interval_num++;
  
  String final_string = intervals.get(current_interval_num % intervals.size());
  
  return final_string;
}
