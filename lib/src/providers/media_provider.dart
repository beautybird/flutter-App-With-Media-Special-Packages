
import 'package:flutter/cupertino.dart';

class MediaProvider with ChangeNotifier{

  List? _mediaList;
  String? _videoData;
  String? _imageData;

  MediaProvider(){
    _mediaList = [];
    _videoData = '';
    _imageData = '';
  }

  List? get mediaList => _mediaList;
  void setMedia(List? media){
    _mediaList = media;
  }

  String? get videoData => _videoData;
  void setVideo(String? video){
    _videoData = video;
  }

  String? get imageData => _imageData;
  void setImage(String image){
    _imageData = image;
  }
}