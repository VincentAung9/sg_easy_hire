import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';

class SupportAvailable extends StatelessWidget {
  const SupportAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: const Row(
        children: [
          Icon(FontAwesomeIcons.circleCheck, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support Available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Average response time: 5 minutes',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          const Icon(Icons.access_time),
        ],
      ),
    );
  }
}
