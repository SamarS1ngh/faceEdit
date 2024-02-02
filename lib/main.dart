import 'package:facedetect/features/camera/screens/camera_screen.dart';
import 'package:facedetect/features/camera/viewModel/camera_model.dart';
import 'package:facedetect/features/edit/viewmodel/edit_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CameraModel>(create: (context) => CameraModel()),
      ChangeNotifierProvider<EditModel>(create: (context) => EditModel()),
    ],
    
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home:   CameraPage());
  }
}
