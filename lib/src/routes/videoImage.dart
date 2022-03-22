import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:special/src/models/model_class.dart';
import 'package:special/src/providers/media_provider.dart';
import 'package:special/src/routes/media_page.dart';
import 'package:special/src/shared_widgets/buttons.dart';
import 'package:special/src/shared_widgets/container.dart';
import 'package:special/src/shared_widgets/form_text_field.dart';

class VideoImage extends StatefulWidget {
  static const routeName = '/videoImage';

  const VideoImage({Key? key}) : super(key: key);

  @override
  _VideoImageState createState() => _VideoImageState();
}

class _VideoImageState extends State<VideoImage> {
  //
  final _addMediaFormKey = GlobalKey<FormState>();
  //
  final _videoLinkController = TextEditingController();
  String? _videoLinkString;
  String? _getVideoLink() {
    _videoLinkString = ((_videoLinkController.text).isNotEmpty == true
        ? _videoLinkController.text
        : '');
    return _videoLinkString;
  }

  final _productController = TextEditingController();
  String _productString = '';
  String? _getProduct() {
    _productString = ((_productController.text).isNotEmpty == true
        ? _productController.text
        : '');
    return _productString;
  }

  final _showMediaController = TextEditingController();
  String? _showMediaString;
  String? _getShowMedia() {
    _showMediaString = ((_showMediaController.text).isNotEmpty == true
        ? _showMediaController.text
        : '');
    return _showMediaString;
  }

  //

  File? _imageFile;
  String? imageFromCamera;
  String? imageFromGallery;
  XFile? imagePickedFile;
  Uint8List? imageBytes;
  String? imageBase64String;

  Future<String?>? _getImageFromCamera(var imageFile) async {
    try {
      imagePickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 60,
          preferredCameraDevice: CameraDevice.rear);
      imageBytes = await imagePickedFile!.readAsBytes();

      imageBase64String = base64Encode(imageBytes!);

      if (imageBase64String!.isNotEmpty == true) {
        imageFromCamera = imageBase64String;
        setState(() => _imageFile = File(imagePickedFile!.path));
      } else {
        imageFromCamera = null;
        setState(() => _imageFile = File(''));
      }
    } catch (err) {
      imageFromCamera = null;
      setState(() => _imageFile = File(''));
      err.toString();
    }
    return imageFromCamera!;
  }

  Future<String?>? _getImageFromGallery(var imageFile) async {
    try {
      imagePickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 60,
          preferredCameraDevice: CameraDevice.rear);

      imageBytes = await imagePickedFile!.readAsBytes();
      imageBase64String = base64Encode(imageBytes!);

      if (imageBase64String!.isNotEmpty == true) {
        imageFromGallery = imageBase64String;
        setState(() => _imageFile = File(imagePickedFile!.path));
      } else {
        imageFromGallery = null;
        setState(() => _imageFile = File(''));
      }
    } catch (err) {
      imageFromGallery = null;
      setState(() => _imageFile = File(''));
      err.toString();
    }
    return imageFromGallery!;
  }

  /*  can remove any image before saving it ...Except Company Logo */
  Future replaceImage(var image) async {
    _imageFile = image;
    image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    setState(() => _imageFile = image);
  }

  ///This to set the no product image in case seller add less than 10 products
  String? noImage;
  String? noProductImageBase64;
  ByteData? bytes;

  Future<String?>? getNoImageData() async {
    bytes = await rootBundle.load('assests/images/noproduct.png');
    noImage = base64Encode(bytes!.buffer.asUint8List(0, bytes!.lengthInBytes));
    var noImageBase64String = getNoImageBase64String(noImage!);

    return noImage!;
  }

  String? getNoImageBase64String(String? noImageBase64String) {
    noProductImageBase64 = noImageBase64String;
    return noProductImageBase64!;
  }

  //Hide the container where video will show
  bool showMediaContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    getNoImageData();
    //
    _videoLinkController.addListener(() {
      _getVideoLink();
    });
    _productController.addListener(() {
      _getProduct();
    });
    _showMediaController.addListener(() {
      _getShowMedia();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoLinkController.dispose();
    _productController.dispose();
    _showMediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create a MediaProvider Instance to assign the fetched data
    //from DB to the List property in the MediaProvider class
    var mediaProviderInstance = Provider.of<MediaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const SizedBox(
            height: 30.0,
            child: Text(
              'Add Video Link',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Form(
              key: _addMediaFormKey,
              child: Column(
                children: [
                  StandardFormTextField(
                    controller: _productController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.blue,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    icon: Icons.ten_k,
                    tooltip: 'Add Product',
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'Add Product',
                    validate: (String? productNameString) =>
                        _productString.isEmpty == true ? 'Add Product' : null,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StandardFormTextField(
                    controller: _videoLinkController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    fieldBorderColor: Colors.blue,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    icon: Icons.ten_k,
                    tooltip: 'Add Video Link',
                    obsecureText: false,
                    maxLines: 1,
                    formTextFieldLabel: 'Add video Link',
                    /*validate: (videoLinkValue) =>
                        videoLinkValue!.isEmpty == true
                            ? 'Add video Link'
                            : null,*/
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 30.0,
                    child: Text(
                      'Add Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  ProductsImagesGridView(
                    imageFile: _imageFile,
                    //image:Image.file(selectedFile(_image)) ,
                    iconGallery: Icons.photo,
                    iconCamera: Icons.camera,
                    iconRemove: Icons.add_photo_alternate,
                    onPressedGallery: () => _getImageFromGallery(_imageFile),
                    onPressedCamera: () => _getImageFromCamera(_imageFile),
                    onPressedRemove: () => replaceImage(_imageFile),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {
                      //
                      if (_addMediaFormKey.currentState!.validate()) {
                        _addMediaFormKey.currentState!.save();

                        String? image;
                        if (imageFromCamera == null) {
                          if (imageFromGallery == null) {
                            image = noImage;
                          } else {
                            image = imageFromGallery;
                          }
                        } else {
                          image = imageFromCamera;
                        }
                        ModelsClass()
                            .saveDataModel(
                                _productString, _videoLinkString, image)!
                            .then((futureResult) {
                          if (futureResult!.contains('save') == true) {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saved')),
                              );
                            });
                          } else {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed Save')),
                              );
                            });
                          }
                        }).onError((error, stackTrace) {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('ERROR Saving')),
                            );
                          });
                        }).whenComplete(() => null);
                      } else {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Fill Product Name Field',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 20.0,
            thickness: 10.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              children: [
                StandardFormTextField(
                  controller: _showMediaController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  fieldBorderColor: Colors.blue,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontColor: Colors.black,
                  icon: Icons.ten_k,
                  tooltip: 'Type Product Name',
                  obsecureText: false,
                  maxLines: 1,
                  formTextFieldLabel: 'Type Product Name',
                  validate: (stringPassValue) =>
                      stringPassValue!.isEmpty == true
                          ? 'Type Product Name'
                          : null,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextButton(
                  onPressed: () {
                    //query database for media..then assign result list
                    // to the List property in the MediaProvider class
                    if (_addMediaFormKey.currentState!.validate()) {
                      _addMediaFormKey.currentState!.save();
                      fetchMediaData(context, _showMediaString)!.then((value) {
                        if (value!.isNotEmpty == true) {
                          print('is not empty');
                          mediaProviderInstance.setMedia(value);
                          setState(() {
                            showMediaContainer = true;
                          });
                        } else {
                          print('is  empty');
                          mediaProviderInstance.setMedia([]);
                          setState(() {
                            showMediaContainer = true;
                          });
                        }
                      }).onError((error, stackTrace) {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error Fetching')),
                          );
                        });
                      }).whenComplete(() => null);
                    } else {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                            'Fill All Fields',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0),
                          )),
                        );
                      });
                    }
                  },
                  child: const Text(
                    'Fetch',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
          const Divider(
            height: 5.0,
            thickness: 5.0,
          ),
          if (showMediaContainer == true) const ShowImageVideo(),
        ],
      ),
    );
  }

  //Fetching Data From DB
  static List? fetchedDataList;
  Future<List?>? fetchMediaData(
      BuildContext context, String? productName) async {
    fetchedDataList = await ModelsClass().fetchDataModel(productName);
    return fetchedDataList;
  }
}

class ProductsImagesGridView extends StatelessWidget {
  final File? imageFile;
  final Image? image;
  final IconData? iconGallery;
  final IconData? iconCamera;
  final IconData? iconRemove;
  final TextEditingController? videoController;
  final Function()? onPressedGallery;
  final Function()? onPressedCamera;
  final Function()? onPressedRemove;

  ProductsImagesGridView({
    this.imageFile,
    this.image,
    this.iconGallery,
    this.iconCamera,
    this.iconRemove,
    this.videoController,
    this.onPressedGallery,
    this.onPressedCamera,
    this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          scrollDirection: Axis.vertical,
          reverse: false,
          controller: ScrollController(
            initialScrollOffset: 0,
            keepScrollOffset: true,
            debugLabel: 'userAccount_Grid',
          ),
          primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2.0),
              //height: 70.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: imageFile == null
                  ? const Text(
                      'No Image Selected',
                    )
                  : Image.file(imageFile!),
            ),
            UserAccountImageButton(
              icon: Icon(
                iconGallery,
                size: 30,
                color: Colors.white,
                semanticLabel: 'userAccountGalleryImage',
              ),
              onPressed: onPressedGallery!,
            ),
            UserAccountImageButton(
              icon: Icon(
                iconCamera,
                size: 30,
                color: Colors.white,
                semanticLabel: 'userAccountCameraImage',
              ),
              onPressed: onPressedCamera!,
            ),
            UserAccountImageButton(
              icon: Icon(
                iconRemove,
                size: 30,
                color: Colors.white,
                semanticLabel: 'userAccountRemoveImage',
              ),
              onPressed: onPressedRemove!,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
