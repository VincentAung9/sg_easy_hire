import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';

class EmptyList extends StatelessWidget {
  final IconData icon;
  final String body;
  const EmptyList({
    required this.icon,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Chat icon with gradient circle and sparkle
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.15),
                      AppColors.background.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.auto_awesome,
                  size: 32,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            body,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
