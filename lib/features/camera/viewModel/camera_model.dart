import 'dart:io';

import 'package:facedetect/features/edit/screens/edit_screen.dart';
import 'package:facedetect/utils/template/view_model.dart';
import 'package:facedetect/utils/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class CameraModel extends BaseViewModel {
  XFile? selectedImage;

  Future<bool> detectFace(context) async {
    File image = File(selectedImage!.path);
    InputImage inputImage = InputImage.fromFile(image);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);

    final List<Face> faces = await faceDetector.processImage(inputImage);
    if (faces.isEmpty) {
      if (context.mounted) {
        showSnackBar(context, 'No Face Detected', Type.failure);
      }
      return false;
    } else if (faces.length != 1) {
      if (context.mounted) {
        showSnackBar(context, 'More than one face detected', Type.failure);
      }
      return false;
    } else {
      return true;
    }
  }

  startCamera(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? image;
    try {
      image = await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), Type.failure);
        return;
      }
    }
    
    if (image == null) {
      if (context.mounted) {
        showSnackBar(context, 'No Image Selected', Type.info);
        return;
      }
    }
    selectedImage = image;
    if (context.mounted) {
      bool check = await  detectFace(context);
      if(!check){
        return;
      }
    }
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const EditPage()),
          (route) => false);
    }
  }
}
