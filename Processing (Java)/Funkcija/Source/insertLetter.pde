String insertLetter(String text, String letter, int index){
  char[] chars = text.toCharArray();
  String result = "";
  
  for (int count = 0; count < chars.length + 1; count++){
    if (count == index){
      result += letter;
    }
    
    try{
      result += chars[count];
    } catch (Exception e){
      
    }
  }
  
  return result;
}

String removeLetter(String text, int index){
  char[] chars = text.toCharArray();
  String result = "";
  
  for (int count = 0; count < chars.length + 1; count++){
    if (count == index){
      continue;
    }
    else{
      try{
        result += chars[count];
      } catch (Exception e){
        
      }
    }
  }
  
  return result;
}
