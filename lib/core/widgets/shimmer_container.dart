import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;
  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // Use a solid color here. When wrapped by Shimmer, this color
          // will be replaced by the animated gradient effect.
          color: Colors
              .white, // Can use any color, but white or light grey is common for placeholders.
          borderRadius: BorderRadius.circular(radius ?? 6.0),
        ),
      ),
    );
  }
}
