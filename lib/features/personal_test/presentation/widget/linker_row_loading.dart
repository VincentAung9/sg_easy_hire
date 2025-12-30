import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';

class LikertRowLoading extends StatelessWidget {
  const LikertRowLoading({
    super.key,
  });

  static const List<double> _sizes = [42, 36, 32, 28, 32, 36, 42];

  @override
  Widget build(BuildContext context) {
    final dots = List.generate(7, (i) {
      final size = _sizes[i];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: ShimmerContainer(
          width: size,
          height: size,
          radius: 100,
        ),
      );
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerContainer(width: 100, height: 20),
            ShimmerContainer(width: 100, height: 20),
          ],
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dots,
          ),
        ),
      ],
    );
  }
}
