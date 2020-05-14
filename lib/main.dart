import 'package:flutter/material.dart';
import 'whatsapphome.dart';
import 'package:camera/camera.dart';
import 'dart:async';

List<CameraDescription> camera;

Future<Null> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  camera=await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "WhatsApp",
      theme: new ThemeData(
        primaryColor: new Color(0xff105E54),
        accentColor: new Color(0xff25D366)
      ),
      debugShowCheckedModeBanner: false,
      home: new WhatsApphome(),
    );
  }
}