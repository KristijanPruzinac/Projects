void exportVideo(){
  videoExport.setQuality(interface1.video_quality, 128);
  videoExport.setFrameRate(interface1.framerate); 
  //noLoop();
  videoExport.startMovie();
}
