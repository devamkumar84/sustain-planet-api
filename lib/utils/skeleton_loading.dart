import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoading extends StatelessWidget{
  final double height;
  final Color? color;

  const SkeletonLoading({super.key, required this.height, required this.color});
  @override
  Widget build(BuildContext context){
    return SkeletonAnimation(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        )
    );
  }
}