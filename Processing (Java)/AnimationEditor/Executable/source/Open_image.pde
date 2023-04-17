void open_file(){
  selectInput("Select a file to open:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection != null) {
    if (loadImage(selection.getAbsolutePath()) != null){
      recent_image = loadImage(selection.getAbsolutePath());
      fileOpened = true;
    }
  }
}
