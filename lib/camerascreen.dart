import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';

class Camerascreen extends StatefulWidget {

  final bool needScaffold;

  Camerascreen({this.needScaffold = false});


  @override
  _CamerascreenState createState() => _CamerascreenState();
}

class _CamerascreenState extends State<Camerascreen>{

  CameraController controller;
  int _cameraIndex = 0;
  bool _cameraNotAvailable = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _initCamera(int index) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(camera[index], ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        _showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {
        _cameraIndex = index;
      });
    }
  }

  void _onSwitchCamera() {
    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }
    final newIndex = _cameraIndex + 1 == camera.length ? 0 : _cameraIndex + 1;
    _initCamera(newIndex);
  }


  void _onTakePictureButtonPress(BuildContext context) {
    _takePicture().then((filePath) {
      if (filePath != null) {
        // _showInSnackBar('Picture saved to $filePath');
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.crop_rotate),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.insert_emoticon),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.text_fields),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            body: Container(
              color: Colors.black,
              child: Center(
                child: new Container(
                  child:Image.file(File(filePath)),
                ),
              ),
            ),
          );
        }));
      }
    });
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!controller.value.isInitialized || controller.value.isTakingPicture) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/whatsapp_clone';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${_timestamp()}.jpg';

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    _showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Widget _buildGalleryBar() {
    final barHeight = 90.0;
    final vertPadding = 10.0;

    return Container(
      height: barHeight,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: vertPadding),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int _) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              width: 70.0,
              height: barHeight - vertPadding * 2,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image:AssetImage("assets/maserati.jpg"),
                  fit: BoxFit.cover,
                ),  
                borderRadius: new BorderRadius.circular(10.0),
              ),
            ),
            onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: new Icon(
                    Icons.send,
                    size: 60.0,
                    color: Colors.green,
                  ),
                  // child: new Text(
                  //   "Send",
                  //   style: new TextStyle(fontWeight: FontWeight.bold)
                  // ),
                  onPressed: (){},
                ),
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.crop_rotate),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.insert_emoticon),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.text_fields),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: Container(
                  color: Colors.black,
                  child: Center(
                    child: new Container(
                      child: new Image.asset("assets/maserati.jpg"),
                    ),
                  ),
                ),
              );
            })),
          );
        },
      ),
    );
  }

  Widget _buildControlBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.flash_auto),
          onPressed: () {},
        ),
        GestureDetector(
          onTap:()=> _onTakePictureButtonPress(context),
          child: Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
          ),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.switch_camera),
          onPressed: _onSwitchCamera,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (camera == null || camera.isEmpty) {
      setState(() {
        _cameraNotAvailable = true;
      });
    }
    _initCamera(_cameraIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraNotAvailable) {
      final center = Center(
        child: Text('Camera not available /_\\'),
      );

      if (widget.needScaffold) {
        return Scaffold(
          appBar: AppBar(),
          body: center,
        );
      }

      return center;
    }

    final stack = Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
          child: Center(
            child: controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  )
                : Text('Loading camera...'),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildGalleryBar(),
            _buildControlBar(context),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Tap for photo',
                style: new TextStyle(fontSize: 12.0,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ],
    );

    if (widget.needScaffold) {
      return Scaffold(
        body: stack,
      );
    }

    return stack;
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller.dispose();
    }
  }
}