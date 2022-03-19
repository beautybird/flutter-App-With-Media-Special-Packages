import 'package:special/src/database/database_class.dart';

class ModelsClass {
  String? saveMediaFuture;
  Future<String?>? saveDataModel(
      String? product, String? video, String? image) async {
    saveMediaFuture = await Databases().saveDetails(product, video, image);
    print('model $saveMediaFuture');
    return saveMediaFuture;
  }

  //Fetching Media Data Model
  List? fetchedMediaFuture;
  Future<List?>? fetchDataModel(String? mediaData) async{
    fetchedMediaFuture = await Databases().queryMedia(mediaData);
    return fetchedMediaFuture;
  }
}
