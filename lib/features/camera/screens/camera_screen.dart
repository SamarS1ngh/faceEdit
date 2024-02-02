import 'package:facedetect/features/camera/viewModel/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    context.read<CameraModel>().startCamera(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
      child: TextButton(
        onPressed: (){
          context.read<CameraModel>().startCamera(context);
        }
        ,child: Text("OPEN Camera"),
      ),
    ));
  }
}
