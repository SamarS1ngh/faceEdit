import 'package:facedetect/features/edit/viewmodel/edit_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GreenArea extends StatelessWidget {
  final int areaType;
  final int index;
  const GreenArea(
      {super.key, this.areaType = AreaType.eye, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditModel>(builder: (context, provider, __) {
      return Positioned(
        left: provider.positions[index].dx,
        top: provider.positions[index].dy,
        child: Draggable(
            hitTestBehavior: HitTestBehavior.opaque,
            feedback: areaType == AreaType.eye ? const Eye() : const Mouth(),
            childWhenDragging:
                Container(),
            onDraggableCanceled: (vel, offset) {
              provider.updatePosition(index, offset);
            },
            child: areaType == AreaType.eye ? const Eye() : const Mouth()),
      );
    });
  }
}

class AreaType {
  static const eye = 0;
  static const mouth = 1;
}

class Eye extends StatelessWidget {
  const Eye({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 64,
      color: Colors.green.withOpacity(0.8),
    );
  }
}

class Mouth extends StatelessWidget {
  const Mouth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 92,
      color: Colors.green.withOpacity(0.8),
    );
  }
}
