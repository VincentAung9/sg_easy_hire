// Add LikertRow widget for dot-based answer selection
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class LikertRow extends StatelessWidget {
  const LikertRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.labels,
  });
  final int? value; // 0..6 (index in answers)
  final ValueChanged<int> onChanged;
  final List<String> labels;

  static const List<double> _sizes = [42, 36, 32, 28, 32, 36, 42];
  static const List<Color> _colors = [
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.grey,
    Colors.purple,
    Colors.purple,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final dots = List.generate(7, (i) {
      final isSelected = value == i;
      final size = _sizes[i];
      final color = _colors[i];
      return InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          safePrint("🌈 Linker row selected answer: $i");
          onChanged(i);
        },
        child: Container(
          width: size,
          height: size,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color,
                    width: isSelected ? 3 : 2,
                  ),
                ),
              ),
              if (isSelected)
                Icon(Icons.check, color: Colors.white, size: size * 0.6),
            ],
          ),
        ),
      );
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labels.first,
              style:
                  Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: labels.first.toLowerCase() == 'disagree'
                        ? Colors.purple
                        : null,
                    fontFamily: 'Arial',
                  ) ??
                  TextStyle(
                    color: labels.first.toLowerCase() == 'disagree'
                        ? Colors.purple
                        : null,
                    fontFamily: 'Arial',
                  ),
            ),
            Text(
              labels.last,
              style:
                  Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: labels.last.toLowerCase() == 'agree'
                        ? Colors.green
                        : null,
                    fontFamily: 'Arial',
                  ) ??
                  TextStyle(
                    color: labels.last.toLowerCase() == 'agree'
                        ? Colors.green
                        : null,
                    fontFamily: 'Arial',
                  ),
            ),
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
