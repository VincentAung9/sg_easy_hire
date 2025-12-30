import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/models/Job.dart';

class HelperJobDetailsView extends StatelessWidget {
  const HelperJobDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final job = GoRouterState.of(context).extra! as Job;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: AppColors.primary,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF4F46E5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button
                        InkWell(
                          onTap: () => context.pop(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Title
                        Text(
                          job.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                job.creator?.avatarURL ?? "",
                              ),
                            ),
                            Text(
                              job.creator?.fullName ?? "",
                              style: const TextStyle(
                                color: Color(0xFFD8B4FE), // purple-200
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 4,
              bottom: 15,
            ), // Padding for footer
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    job.createdAt == null
                        ? const SizedBox()
                        : Text(
                            timeAgo(job.createdAt!),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                    Row(
                      spacing: 4,
                      children: [
                        const Text(
                          "Salary:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Chip(
                          label: Text("\$${job.salary}/${job.payPeriod}"),
                          backgroundColor: Colors.green[100],
                          side: BorderSide.none,
                          labelStyle: TextStyle(
                            color: Colors.green[600],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  job.note ?? "",
                ),
                Wrap(
                  spacing: 5,
                  children: [
                    ...List.generate(
                      (job.requiredSkills ?? []).length,
                      (index) {
                        final skill = (job.requiredSkills ?? [])[index];
                        return Chip(
                          label: Text(skill),
                          backgroundColor: Color(0xFFDBEAFE),
                          labelStyle: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                        );
                      },
                    ),
                    job.offdays == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Off Day: ${job.offdays}"),
                            backgroundColor: const Color.fromARGB(
                              255,
                              225,
                              228,
                              234,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                    job.childCount == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Children: ${job.childCount}"),
                            backgroundColor: const Color.fromARGB(
                              255,
                              225,
                              228,
                              234,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                    job.childAges == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Children are ${job.childAges}"),
                            backgroundColor: Color.fromARGB(255, 225, 228, 234),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                    job.adultCount == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Adult: ${job.adultCount}"),
                            backgroundColor: Color.fromARGB(255, 225, 228, 234),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                    job.elderlyCount == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Elderly: ${job.elderlyCount}"),
                            backgroundColor: Color.fromARGB(255, 225, 228, 234),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                    job.homeType == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Home Type: ${job.homeType}"),
                            backgroundColor: Color.fromARGB(255, 225, 228, 234),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                    job.roomType == null
                        ? const SizedBox()
                        : Chip(
                            label: Text("Room Type: ${job.roomType}"),
                            backgroundColor: Color.fromARGB(255, 225, 228, 234),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
