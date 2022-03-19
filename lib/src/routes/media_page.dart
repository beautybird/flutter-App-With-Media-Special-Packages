import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:special/src/providers/media_provider.dart';
import 'package:special/src/shared_widgets/container.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/*
* Add images and videos to a container,we can set a sequence to show either the
* images , the videos or both.
* */

class ShowImageVideo extends StatefulWidget {
  const ShowImageVideo({Key? key}) : super(key: key);

  @override
  _ShowImageVideoState createState() => _ShowImageVideoState();
}

class _ShowImageVideoState extends State<ShowImageVideo> {

  YoutubePlayerController? _controller;
  TextEditingController? _idController;
  TextEditingController? _seekToController;

  PlayerState? _playerState;
  YoutubeMetaData? _videoMetaData;
  double? _volume = 100;
  bool? _muted = false;
  bool? _isPlayerReady = false;

  //If you wish show list of videos
  final List<String?>? _ids = [
    'video_address_1',
    'video_address_2',
  ];

  // Create image and video variables...assign values to them
  //from the MediaProvider
  String? videoDataValue;
  String? imageDataValue;
  MediaProvider? mediaProviderInstance;
  //
  @override
  void initState() {
    // TODO: implement initState
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    videoDataValue = '';
    imageDataValue = '';

    super.initState();

    //Initialize the media
    //getSelectedMedia();
  }

  void listener() {
    if (_isPlayerReady! && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        _playerState = _controller!.value.playerState;
        _videoMetaData = _controller!.metadata;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_controller != null) {
      _controller!.dispose();
      _idController!.dispose();
      _seekToController!.dispose();
    }
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    if (_controller != null) {
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    //We create a MediaProvider instance to get the media in the media list
    mediaProviderInstance = Provider.of<MediaProvider>(context);

    return Scaffold(
      body: getSelectedMedia(),
    );
  }

  Widget? selectedMedia;
  Widget? getSelectedMedia() {
    if(mediaProviderInstance!.mediaList!.isEmpty == true){
      setState(() {
        selectedMedia = Image.asset('assets/images/noproduct.png');
      });
    }else if (videoDataValue.toString().contains('null') == true ||
        videoDataValue!.isEmpty == true ||
        videoDataValue == null) {
      setState(() {
        selectedMedia = getImageData();
      });
    } else {
      _getVideoController();
      selectedMedia = prLogoVideoWidget();
      Timer(const Duration(seconds: 30), () {
        if (!mounted) return;
        setState(() {
          selectedMedia = getImageData();
        });
      });
    }

    return selectedMedia;
  }

  Widget? prLogoVideo;
  Widget? prLogoVideoWidget() {
    prLogoVideo = YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {
          _controller!.addListener(listener);
        },
      ),
      builder: (context, player) {
        return ContainerStandard(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5.0),
          minWidth: 300.0,
          maxWidth: 300.0,
          minHeight: 100.0,
          maxHeight: 250.0,
          color: Colors.white,
          boxBorderColor: Colors.yellow,
          boxBorderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxBorder: Border.all(
            color: Colors.yellowAccent,
            width: 0.8,
            style: BorderStyle.solid,
          ),
          gradientColorOne: Colors.teal,
          gradientColorTwo: Colors.green,
          /*  image: DecorationImage(
          image: MemoryImage(sellerShopLogo!),
          colorFilter: ColorFilter.linearToSrgbGamma(),
          fit: BoxFit.fill,
          alignment: Alignment.center,
          centerSlice: Rect.fromLTRB(1.0, 1.0, 1.0, 1.0),
          repeat: ImageRepeat.noRepeat,
          matchTextDirection: false,
        ),*/
          child: player,
        );
      },
    );

    return prLogoVideo;
  }

  YoutubePlayerController? _getVideoController() {
    return _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoDataValue.toString())!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  //Image
  Image? imageSelectedFromSource;
  Image? getImageData() {
    if (imageDataValue!.isNotEmpty == true) {
      imageSelectedFromSource = Image.memory(
        base64.decode(imageDataValue!),
      );
    } else {
      imageSelectedFromSource = Image.asset('assets/images/noproduct.png');
    }
    return imageSelectedFromSource;
  }
}
