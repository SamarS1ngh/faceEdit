import 'dart:developer';
import 'dart:io';

import 'package:facedetect/features/camera/viewModel/camera_model.dart';
import 'package:facedetect/features/edit/widgets/green_area.dart';
import 'package:facedetect/utils/template/view_model.dart';
import 'package:facedetect/utils/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:provider/provider.dart';

class EditModel extends BaseViewModel {
  File? selectedImage;

  getImage(BuildContext context) {
    selectedImage = File(context.read<CameraModel>().selectedImage!.path);
  }

  int eyeType = 0;
  int mouthType = 0;

  saveImage(BuildContext context) {}
  List<GreenArea> _green = [];
  List<Offset> _position = [];
  List<GreenArea> get greenWidgets => _green;
  List<Offset> get positions => _position;

  clearWidgets() {
    _green.clear();
    _position.clear();
  }

  addGreen(BuildContext context, int type) {
    if (AreaType.eye == type) {
      eyeType++;
    }
    if (AreaType.mouth == type) {
      mouthType++;
    }

    if (eyeType > 2) {
      showSnackBar(context, 'You have more than 2 eyes?! ', Type.failure);
      eyeType--;
      return;
    }

    if (mouthType > 1) {
      showSnackBar(context, 'You have more than 1 mouth?! ', Type.failure);
      mouthType--;
      return;
    }
    final size = MediaQuery.of(context).size;
    GreenArea widget = GreenArea(
      index: _green.length,
      areaType: type,
    );
    _green.add(widget);
    _position.add(Offset(size.width / 2, size.height / 2));
    notifyListeners();
  }

  updatePosition(int index, Offset offset) {
    positions[index] = offset;
    notifyListeners();
  }
}
