import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';

class ChatRoomItemLoading extends StatelessWidget {
  const ChatRoomItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16), // rounded-lg
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          ShimmerContainer(
            width: 60,
            height: 60,
            radius: 30,
          ),
          SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(width: 100, height: 20),
                    SizedBox(width: 10),
                    ShimmerContainer(width: 30, height: 20),
                  ],
                ),
                SizedBox(height: 4),
                ShimmerContainer(width: 100, height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
