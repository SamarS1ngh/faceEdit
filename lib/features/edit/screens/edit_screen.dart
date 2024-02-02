import 'dart:typed_data';

import 'package:facedetect/features/camera/screens/camera_screen.dart';
import 'package:facedetect/features/edit/viewmodel/edit_model.dart';
import 'package:facedetect/features/edit/widgets/green_area.dart';
import 'package:facedetect/utils/widgets/button.dart';
import 'package:facedetect/utils/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  ScreenshotController screenshotCtrlr = ScreenshotController();

  saveToGallery() {
    screenshotCtrlr.capture().then((Uint8List? img) {
      saveScreenshot(img!);
    });
  }

  saveScreenshot(Uint8List bytes) async {
    final time = DateTime.now();
    final name = "Image $time";
    await ImageGallerySaver.saveImage(bytes, name: name);
    showSnackBar(context, 'Image saved to gallery ', Type.success);
  }

  @override
  Widget build(BuildContext context) {
    context.read<EditModel>().getImage(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        child: Button(
          onTap: saveToGallery,
          label: 'Save to Gallery',
          shrink: false,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Consumer<EditModel>(builder: (_, provider, __) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Screenshot(
                    controller: screenshotCtrlr,
                    child: Stack(
                      children: [
                        Image.file(provider.selectedImage!),
                        ...provider.greenWidgets,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              provider.clearWidgets();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CameraPage()),
                                  (route) => false);
                            },
                            child: const Text('Go Back')),
                        Row(
                          children: [
                            Button(
                                onTap: () {
                                  provider.addGreen(context, AreaType.eye);
                                },
                                label: "Eye"),
                            Button(
                                onTap: () {
                                  provider.addGreen(context, AreaType.mouth);
                                },
                                label: "Mouth")
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
