import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final bool shrink;
  const Button({super.key,required this.onTap,required this.label,this.shrink =true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap:onTap,
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          height: shrink? 84:48, width: shrink? 84:MediaQuery.sizeOf(context).width,
          //TODO:TextStyles
        child:Center(child: Text(label),) ,),
      ),
    );
  }
}