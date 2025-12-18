import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';

class JobCardShimmer extends StatelessWidget {
  const JobCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // The entire content structure is wrapped inside Shimmer.fromColors.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardLight, // Background of the card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Title, Employer, and Salary/Favorite Shimmer ---
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Job Title Shimmer (Child 1)
                    ShimmerContainer(width: 150, height: 18),
                    SizedBox(height: 6),
                    // Employer Name Shimmer (Child 2)
                    ShimmerContainer(width: 100, height: 16),
                  ],
                ),
              ),
              Row(
                children: [
                  // Salary Chip Shimmer (Child 3)
                  ShimmerContainer(width: 60, height: 32, radius: 20),
                  SizedBox(width: 12),
                  // Favorite Icon Shimmer (Child 4)
                  ShimmerContainer(width: 28, height: 28, radius: 14),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // --- Additional Requirements (Description) Shimmer ---
          const ShimmerContainer(width: double.infinity, height: 14),
          const SizedBox(height: 5),
          const ShimmerContainer(width: double.infinity, height: 14),
          const SizedBox(height: 5),
          const ShimmerContainer(width: 200, height: 14),
          const SizedBox(height: 10),

          // --- Skills and OffDays Chips Shimmer ---
          const Wrap(
            spacing: 5,
            children: [
              ShimmerContainer(width: 70, height: 26, radius: 20),
              ShimmerContainer(width: 50, height: 26, radius: 20),
              ShimmerContainer(width: 85, height: 26, radius: 20),
              ShimmerContainer(width: 70, height: 26, radius: 20),
            ],
          ),

          Divider(color: Colors.grey[100]),

          // --- Time Ago Shimmer ---
          const ShimmerContainer(width: 80, height: 14),
          const SizedBox(height: 10),

          // --- Buttons Shimmer ---
          const Row(
            children: [
              // View Details Button Shimmer
              Expanded(
                child: ShimmerContainer(
                  width: double.infinity,
                  height: 48,
                  radius: 8,
                ),
              ),
              SizedBox(width: 10),
              // Apply Button Shimmer
              Expanded(
                child: ShimmerContainer(
                  width: double.infinity,
                  height: 48,
                  radius: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
