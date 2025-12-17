import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const ButtonLoading({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 30,
        width: width ?? 30,
        child: CupertinoActivityIndicator(color: color ?? Colors.white),
      ),
    );
  }
}
