void load(){
  //učitavanje zadataka
  zadaci_lista = loadStrings("Zadaci.txt");
  
  for (String line : zadaci_lista){
    zadaci.add(new zadatak(split(line, ";")[0], int(split(line, ";")[1]), split(line, ";")[2]));
  }
}

void refresh(){
  date = 0;
  
  for (int i = 0; i < month - 1; i++){
    date += month_lengths[i];
  }
  
  date += day;
  
}

int getDate(int mjesec, int dan){
  
  int return_date = 0;
  
  for (int i = 0; i < mjesec - 1; i++){
    return_date += month_lengths[i];
  }
  
  return_date += dan;
  
  return return_date;
}

void real_time_refresh(){
  this_sec = second();
  if (this_sec != last_sec){
    
    //refresh datuma
    refresh();
    last_sec = second();
    
    //refresh sata
    hour = hour();
    minute = minute();
    second = second();
    
    //namjesti sat
    if (hour < 10){
      hour_string = "0" + hour;
    }
    else{
      hour_string = str(hour);
    }
    
    if (minute < 10){
      minute_string = "0" + minute;
    }
    else{
      minute_string = str(minute);
    }
    
    if (second < 10){
      second_string = "0" + second;
    }
    else{
      second_string = str(second);
    }
  }
}

//internalne programske funkcije
void drawTime(){
  //sat
  textSize(40);
  fill(255);
  text(hour_string + ":" + minute_string + ":" + second_string, width - 200, 65);
}

void drawInterface(){
  //top bar
  noStroke();
  fill(100, 200, 100);
  rect(0, 0, width, 100);
  
  //new button
  noStroke();
  fill(255);
  rect(20, 20, 80, 80);
  image(plus, 15, 15, 85, 85);
  
  //new settings
  
  //ime
  fill(255);
  rect(120, 20, 400, 80);
  textSize(40);
  fill(25);
  if (add_ime.length() != 0){
    text(add_ime, 125, 65);
  }
  else {
    fill(235);
    text("Predmet", 125, 65);
  }
  
  //datum
  fill(255);
  rect(450, 20, 550, 80);
  textSize(40);
  fill(25);
  if (add_day.length() != 0){
    text(add_day, 475, 65);
  }
  else {
    fill(235);
    text("D", 460, 65);
  }
  
  fill(255);
  rect(565, 20, 665, 80);
  textSize(40);
  fill(25);
  if (add_month.length() != 0){
    text(add_month, 590, 65);
  }
  else {
    fill(235);
    text("M", 570, 65);
  }
  
  //opis
  fill(255);
  rect(680, 20, 1510, 80);
  textSize(40);
  fill(25);
  if (add_opis.length() != 0){
    text(add_opis, 685, 65);
  }
  else {
    fill(235);
    text("Opis", 685, 65);
  }
  
  //underline
  if (selected_add_element == 1){
    fill(255);
    rect(120, 85, 400, 90);
  }
  else if (selected_add_element == 2){
    fill(255);
    rect(450, 85, 550, 90);
  }
  else if (selected_add_element == 3){
    fill(255);
    rect(565, 85, 665, 90);
  }
  else if (selected_add_element == 4){
    fill(255);
    rect(680, 85, 790, 90);
  }
  else if (selected_add_element == 5){
    fill(255);
    rect(680, 85, 1510, 90);
  }
}

void drawBackground(){
  //list background
  noStroke();
  fill(140);
  rect(0, 100, width, height);
}

void drawScrollBar(){
  noStroke();
  fill(255); 
  rect(width - 25, 100 + scroll_pos, width, 100 + scroll_pos + scroll_length);
}

void adjustScrollBar(){
  try {
    scroll_length = (height - 100) / ceil((float(zadaci.size()) / float(8))); 
  }
  catch (Exception e){
    
  }
}

void drawTasks(){
  translate(0, zadaci_offset);
  for (int i = 0; i < zadaci.size(); i++){
    
    fill(200);
    if (zadaci.get(i).datum - date < 0){
      strokeWeight(3);
      stroke(200, 0, 0);
    }
    else {
      noStroke();
    }
    rect(150 + ((i % 4) * 400), 200 + (floor((float(i) / 4)) * 400), 450 + ((i % 4) * 400), 500 + (floor((float(i) / 4)) * 400));
    image(x, 420 + ((i % 4) * 400), 180 + (floor((float(i) / 4)) * 400));
    textSize(32);
    noStroke();
    if (zadaci.get(i).datum - date == 0){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 255 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text("Danas", 149 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date == 1){
      fill(195, 210, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 255 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text("Sutra", 157 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date > 1 && zadaci.get(i).datum - date < 10){
      fill(0, 190, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 265 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text(zadaci.get(i).datum - date + " dana", 148 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date > 9 && zadaci.get(i).datum - date < 100){
      fill(0, 190, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 280 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text(zadaci.get(i).datum - date + " dana", 148 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date > 99){
      fill(0, 190, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 300 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text(zadaci.get(i).datum - date + " dana", 148 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date == -1){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 255 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text("Jučer", 159 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date < -1 && zadaci.get(i).datum - date > -10){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 350 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text("Prije " + str(-(zadaci.get(i).datum - date)) + " dana", 157 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else if (zadaci.get(i).datum - date < -9 && zadaci.get(i).datum - date > -100){
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 370 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text("Prije " + str(-(zadaci.get(i).datum - date)) + " dana", 157 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    else {
      fill(200, 0, 0);
      rect(140 + ((i % 4) * 400), 160 + (floor((float(i) / 4)) * 400), 390 + ((i % 4) * 400), 210 + (floor((float(i) / 4)) * 400));
      fill(255);
      text("Prije " + str(-(zadaci.get(i).datum - date)) + " dana", 157 + ((i % 4) * 400), 193 + (floor((float(i) / 4)) * 400));
    }
    
    fill(255);
    textSize(40);
    text(zadaci.get(i).ime, 160 + ((i % 4) * 400), 260 + (floor((float(i) / 4)) * 400));
    
    fill(255);
    textSize(20);
    //if (zadaci.get(i).opis.indexOf("#") != -1){
    //  String[] opis_linije = split(zadaci.get(i).opis, "#");
    //  int l = 0;
    //  for (String line : opis_linije){
    //    text(line, 160 + ((i % 4) * 400), 295 + (26 * l) + (floor((float(i) / 4)) * 400));
    //    l++;
    //  }
    //}
    //else {
    //  text(zadaci.get(i).opis, 160 + ((i % 4) * 400), 295 + (floor((float(i) / 4)) * 400));
    //}
    
    text(zadaci.get(i).opis, 160 + ((i % 4) * 400), 295 + (floor((float(i) / 4)) * 400), 430 + ((i % 4) * 400), 480 + (floor((float(i) / 4)) * 400));
  }
  translate(0, -zadaci_offset);
}

void sortTasks(){
  ArrayList<zadatak> sorted_zadaci = new ArrayList<zadatak>();
  for (int i = -700; i < 700; i++){
    for (zadatak zadatak : zadaci){
      if (zadatak.datum - date == i){
        sorted_zadaci.add(zadatak);
      }
    }
  }
  zadaci = sorted_zadaci;
}
