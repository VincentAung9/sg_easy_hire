import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class HoverContainer extends StatefulWidget {
  final Widget child;

  const HoverContainer({super.key, required this.child});

  @override
  State<HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primaryPurple50 : Colors.transparent,
          border: Border.all(
            color: _isHovered ? AppColors.primary : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: widget.child,
      ),
    );
  }
}
