import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mausam_app/screens/loading.dart';
// import 'package:mausam_app/screens/location.dart';

void main() {
  // Set preferred orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MaterialApp(debugShowCheckedModeBanner: false, routes: {
    "/": (context) => const Loading(),
    // "/home": (context) => const Home(),
    // "/location": (context) => const Location(),
  }));
}
