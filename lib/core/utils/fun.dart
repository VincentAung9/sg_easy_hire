import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_state.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/helper_home/domain/other/count_down_state.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ApplicationStatus.dart';
import 'package:sg_easy_hire/models/ChatStatus.dart';
import 'package:sg_easy_hire/models/InterviewStatus.dart';
import 'package:sg_easy_hire/models/JobOfferStatus.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:sg_easy_hire/models/Review.dart';
import 'package:sg_easy_hire/models/UploadedDocuments.dart';
import 'package:sg_easy_hire/models/User.dart';
import 'package:sg_easy_hire/models/VerifyStatus.dart';
import 'package:shimmer/shimmer.dart';

class InterviewStatusUI {
  final String text;
  final IconData icon;
  final Color color;
  final Color bgColor;

  InterviewStatusUI({
    required this.text,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

class ProfileStatusUI {
  final String text;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String description;

  ProfileStatusUI({
    required this.text,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.description,
  });
}

void showNoti(BuildContext context, String title, String body) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.orange[100]!,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text("🔔", style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(title, style: TextStyle(fontSize: 14)),
        subtitle: Text(body, style: TextStyle(fontSize: 12)),
      ),
      backgroundColor: Colors.orange[100]!,
    ),
  );
}

void showSnack(BuildContext context, String message, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(fontSize: 12)),
      backgroundColor: backgroundColor,
    ),
  );
}

int getYearFromString(String value) {
  final match = RegExp(r'\d+').firstMatch(value);
  return match != null ? int.parse(match.group(0)!) : 0;
}

int calculateAge(String dateOfBirthString) {
  final dateOfBirth = birthDayToDate(dateOfBirthString);
  final now = DateTime.now();

  // 1. Calculate the difference in years.
  // This gives an initial estimate of the age.
  int age = now.year - dateOfBirth.year;

  // 2. Check if the current date is before the birthday this year.
  // If the current month is before the birth month, the person hasn't had their birthday yet.
  if (now.month < dateOfBirth.month) {
    age--;
  }
  // If the current month is the birth month, check the day.
  else if (now.month == dateOfBirth.month) {
    // If the current day is before the birth day, the person hasn't had their birthday yet.
    if (now.day < dateOfBirth.day) {
      age--;
    }
  }

  // If the month is after the birth month (or it's the same month and the day has passed or is today),
  // the initial 'age' calculation is correct.

  return age;
}

DateTime birthDayToDate(String bd) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  if (bd.contains(".")) {
    bd = bd.replaceFirst(".", "/");
  }
  // 2. Use the formatter's parse method to convert the string to a DateTime object.
  final DateTime dateOfBirth = formatter.parse(bd);
  return dateOfBirth;
}

InterviewStatusUI getInterviewStatusUI(
  InterviewStatus status,
  AppLocalizations t,
) {
  switch (status) {
    case InterviewStatus.PENDING:
      return InterviewStatusUI(
        text: t.helperInterviews_tabPending,
        icon: Icons.schedule,
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
      );

    case InterviewStatus.ACCEPTED:
      return InterviewStatusUI(
        text: t.helperInterviews_tabAccepted,
        icon: Icons.check_circle,
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFD1FAE5),
      );

    case InterviewStatus.COMPLETED:
      return InterviewStatusUI(
        text: t.helperInterviews_tabCompleted,
        icon: Icons.check,
        color: const Color(0xFF3B82F6),
        bgColor: const Color(0xFFDBEAFE),
      );

    case InterviewStatus.CANCELLED:
      return InterviewStatusUI(
        text: t.helperInterviews_tabCancelled,
        icon: Icons.cancel,
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      );

    case InterviewStatus.NO_SHOW:
      return InterviewStatusUI(
        text: t.interviewStatusNoShow,
        icon: Icons.check,
        color: const Color(0xFF3B82F6),
        bgColor: const Color(0xFFDBEAFE),
      );
    case InterviewStatus.PROCESSING:
      return InterviewStatusUI(
        text: t.interviewStatusProcessing,
        icon: Icons.hourglass_top,
        color: const Color(0xFFF59E0B), // amber
        bgColor: const Color(0xFFFEF3C7),
      );
  }
}

ProfileStatusUI getProfileStatus(VerifyStatus status, AppLocalizations t) {
  switch (status) {
    case VerifyStatus.PENDING:
      return ProfileStatusUI(
        text: t.profilePendingTitle,
        description: t.profilePendingDesc,
        icon: Icons.schedule,
        color: const Color(0xFFF59E0B), // amber
        bgColor: const Color(0xFFFEF3C7).withOpacity(0.12),
      );

    case VerifyStatus.VERIFIED:
      return ProfileStatusUI(
        text: t.profileApprovedTitle,
        description: t.profileApprovedDesc,
        icon: Icons.check_circle,
        color: const Color(0xFF16A34A), // green
        bgColor: const Color(0xFFDCFCE7).withOpacity(0.12),
      );

    case VerifyStatus.UNVERIFIED:
      return ProfileStatusUI(
        text: t.profileRejectedTitle,
        description: t.profileRejectedDesc,
        icon: Icons.cancel,
        color: const Color(0xFFDC2626), // red
        bgColor: const Color(0xFFFEE2E2).withOpacity(0.12),
      );
  }
}

InterviewStatusUI getOfferedJobStatusUI(ApplicationStatus status) {
  switch (status) {
    case ApplicationStatus.PENDING:
      return InterviewStatusUI(
        text: "Pending",
        icon: Icons.schedule,
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
      );

    case ApplicationStatus.ACCEPTED:
      return InterviewStatusUI(
        text: "Accepted",
        icon: Icons.check_circle,
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFD1FAE5),
      );

    case ApplicationStatus.REJECTED:
      return InterviewStatusUI(
        text: "Cancelled",
        icon: Icons.cancel,
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      );

    /* case JobOfferStatus.:
      return InterviewStatusUI(
        text: "Rejected",
        icon: Icons.cancel,
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      ); */
  }
}

String formatInterviewDateTime(TemporalDateTime temporalDateTime) {
  //final formatMethod = DateFormat.yMd().add_jm();
  final date = temporalDateTime.getDateTimeInUtc().toLocal();
  return "🗓 ${formatDateMMMdyyyy(date)} 🕓 ${formatTimeHMMA(date)}";
  //return formatMethod.format(date);
}

String timeAgo(TemporalDateTime temporalDateTime) {
  final date = temporalDateTime.getDateTimeInUtc().toLocal();
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inSeconds < 60) {
    return "just now";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes} min${diff.inMinutes == 1 ? '' : 's'} ago";
  } else if (diff.inHours < 24) {
    return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
  } else if (diff.inDays < 7) {
    return "${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago";
  } else if (diff.inDays < 30) {
    final weeks = diff.inDays ~/ 7;
    return "$weeks week${weeks == 1 ? '' : 's'} ago";
  } else if (diff.inDays < 365) {
    final months = diff.inDays ~/ 30;
    return "$months month${months == 1 ? '' : 's'} ago";
  } else {
    final years = diff.inDays ~/ 365;
    return "$years year${years == 1 ? '' : 's'} ago";
  }
}

Map<String, dynamic> getInterviewAction(
  InterviewStatus status,
  AppLocalizations t,
) {
  switch (status) {
    case InterviewStatus.PENDING:
      return {
        "text": t.interviewStatusAccept,
        "bgColor": Colors.green[100],
        "fgColor": Colors.green[600],
      };

    case InterviewStatus.ACCEPTED:
      return {
        "text": t.interviewStatusCancel,
        "bgColor": Colors.red[100],
        "fgColor": Colors.red[500],
      };

    case InterviewStatus.COMPLETED:
      return {
        "text": t.interviewStatusCompleted,
        "bgColor": Colors.grey[200],
        "fgColor": Colors.grey[600],
      };

    case InterviewStatus.CANCELLED:
      return {
        "text": t.interviewStatusCancelled,
        "bgColor": Colors.grey[300],
        "fgColor": Colors.grey[700],
      };

    case InterviewStatus.NO_SHOW:
      return {
        "text": t.interviewStatusNoShow,
        "bgColor": Colors.grey[300],
        "fgColor": Colors.grey[700],
      };
    case InterviewStatus.PROCESSING:
      return {
        "text": t.interviewStatusProcessing,
        "bgColor": Colors.grey[300],
        "fgColor": Colors.grey[700],
      };
  }
}

Future<TemporalDateTime?> showInterviewTimeSelectionDialog(
  BuildContext context,
  List<TemporalDateTime> options,
) async {
  final t = AppLocalizations.of(context);
  return showDialog<TemporalDateTime>(
    context: context,
    builder: (context) {
      TemporalDateTime? selected;
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        t.selectInterviewTime,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    t.selectInterviewTimeSubtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Time Slots
                  ...options
                      .map(
                        (op) => {
                          'date': formatDateMMMdyyyy(
                            op.getDateTimeInUtc().toLocal(),
                          ),
                          'time': formatTimeHMMA(
                            op.getDateTimeInUtc().toLocal(),
                          ),
                          'value': op,
                        },
                      )
                      .map((slot) {
                        final isSelected = selected == slot['value'];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selected = slot['value'] as TemporalDateTime;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.08)
                                    : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.radio_button_checked,
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.grey.shade300,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              slot['date'] as String,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              slot['time'] as String,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      .toList(),

                  const SizedBox(height: 28),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: selected == null
                          ? null
                          : () {
                              // Handle confirmation
                              Navigator.pop(context, selected);
                              showSuccess(
                                context,
                                t.interviewScheduledSuccess,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        t.confirmSelection,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        t.cancel,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

/* Future<TemporalDateTime?> showInterviewDateDialog(
  BuildContext context,
  List<TemporalDateTime> options,
) async {
  return showDialog<TemporalDateTime>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      TemporalDateTime? selected;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              "Choose Interview Time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((e) {
                  final formatted = formatInterviewDateTime(e);
                  return RadioListTile<TemporalDateTime>(
                    title: Text(formatted),
                    value: e,
                    groupValue: selected,
                    onChanged: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selected == null
                      ? Colors.grey
                      : AppColors.primary,
                ),
                onPressed: selected == null
                    ? null
                    : () => Navigator.pop(context, selected),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: selected == null ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
 */
bool isTomorrow(DateTime input) {
  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  final inputDateOnly = DateTime(input.year, input.month, input.day);

  return inputDateOnly == tomorrow;
}

String formatDateMMMdy(DateTime date) {
  return DateFormat("MMM d, y").format(date);
}

String formatDateMMMdyyyy(DateTime date) {
  return DateFormat("MMM d, yyyy").format(date);
}

String formatDateMMMd(DateTime date) {
  return DateFormat("MMM d").format(date);
}

String formatTimeHMMA(DateTime date) {
  return DateFormat("h:mm a").format(date);
}

Widget buildShimmerContainer({
  required double width,
  required double height,
  double radius = 6.0,
}) {
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
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

Widget buildProfileAvatar({String? imageUrl, double radius = 30}) {
  return Container(
    width: radius * 2,
    height: radius * 2,
    // Slight translucent white border behind avatar to match original look
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 0.2),
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: ClipOval(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey.shade300,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: radius / 2, color: Colors.grey),
              )
            : const Icon(Icons.person, size: 50, color: Colors.grey),
      ),
    ),
  );
}

TextStyle title = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
TextStyle subTitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);

String formatPrice(int price) {
  final formatter = NumberFormat('#,###');
  String formattedPrice = formatter.format(price);
  return formattedPrice;
}

Widget widgetLoading({Color? color}) => Center(
  child: SizedBox(
    height: 50,
    width: 50,
    child: CupertinoActivityIndicator(color: color ?? Colors.black),
  ),
);
Widget screenLoading({required BuildContext context, Color? color}) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
    height: size.height,
    width: size.width,
    child: Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CupertinoActivityIndicator(color: color ?? Colors.black),
      ),
    ),
  );
}

String getChatRoomName(String userAID, String userBID) {
  if (userAID.compareTo(userBID) > 0) {
    return "$userAID-$userBID";
  } else {
    return "$userBID-$userAID";
  }
}

Widget getChatStatus(ChatStatus status) {
  switch (status) {
    case ChatStatus.PENDING:
      return const Text("");
    case ChatStatus.SENT:
      return const Row(
        children: [Icon(FontAwesomeIcons.check, size: 12, color: Colors.grey)],
      );
    case ChatStatus.RECEIVED:
      return const Row(
        children: [
          Icon(FontAwesomeIcons.checkDouble, size: 12, color: Colors.grey),
        ],
      );
    case ChatStatus.SEEN:
      return const Row(
        children: [
          Icon(
            FontAwesomeIcons.checkDouble,
            size: 12,
            color: AppColors.primary,
          ),
        ],
      );
    case ChatStatus.TYPING:
      return const Text("typing...");
  }
}

String capitalize(String value) {
  if (value.isEmpty) return value;
  return value[0].toUpperCase() + value.substring(1);
}

String formatFileSize(int bytes) {
  if (bytes <= 0) return '0 B';

  const units = ['B', 'KB', 'MB', 'GB', 'TB'];
  int unitIndex = 0;
  double size = bytes.toDouble();

  while (size >= 1024 && unitIndex < units.length - 1) {
    size /= 1024;
    unitIndex++;
  }

  return '${size.toStringAsFixed(2)} ${units[unitIndex]}';
}

String platformFileToAWSJson(
  PlatformFile file, {
  String? uploadedUrl,
}) {
  return jsonEncode({
    'name': file.name,
    'size': file.size,
    'extension': _getExtension(file.name),
    'url': uploadedUrl, // null for draft, set after upload
  });
}

PlatformFile awsJsonToPlatformFile(String awsJson) {
  final json = jsonDecode(awsJson) as Map<String, dynamic>;

  return PlatformFile(
    name: json['name'] as String,
    size: json['size'] as int,
    path: json['path'] as String?, // may be null (expected for drafts)
  );
}

String? _getExtension(String fileName) {
  final index = fileName.lastIndexOf('.');
  if (index == -1) return null;
  return fileName.substring(index + 1).toLowerCase();
}

String? getFileExtension(PlatformFile file) {
  final name = file.name;
  final index = name.lastIndexOf('.');
  return index != -1 ? name.substring(index + 1) : null;
}

String fileKey(PlatformFile f) => f.path ?? f.name;

UploadedDocuments uploadedResultsToUploadedDocuments({
  required Map<DocumentType, dynamic> uploadedResults,
  required User user,
  UploadedDocuments? oldData,
}) {
  return oldData == null
      ? UploadedDocuments(
          code: nanoid(10),
          createdAt: TemporalDateTime(DateTime.now()),
          profilePhoto: uploadedResults[DocumentType.profilePhoto] as String?,
          passport: uploadedResults[DocumentType.passport] as String?,
          medicalCertificate:
              uploadedResults[DocumentType.medicalCertificate] as String?,
          policeClearance:
              uploadedResults[DocumentType.policeClearance] as String?,
          educationalCertificates: castStringList(
            uploadedResults[DocumentType.educationalCertificates],
          ),
          workReferences: castStringList(
            uploadedResults[DocumentType.workReferences],
          ),
          introductionVideo:
              uploadedResults[DocumentType.introductionVideo] as String?,
          isPublished: true,
          user: user,
        )
      : oldData.copyWith(
          updatedAt: TemporalDateTime(DateTime.now()),
          profilePhoto: uploadedResults[DocumentType.profilePhoto] as String?,
          passport: uploadedResults[DocumentType.passport] as String?,
          medicalCertificate:
              uploadedResults[DocumentType.medicalCertificate] as String?,
          policeClearance:
              uploadedResults[DocumentType.policeClearance] as String?,
          educationalCertificates: castStringList(
            uploadedResults[DocumentType.educationalCertificates],
          ),
          workReferences: castStringList(
            uploadedResults[DocumentType.workReferences],
          ),
          introductionVideo:
              uploadedResults[DocumentType.introductionVideo] as String?,
          isPublished: true,
          user: user,
        );
}

void printFull(String text) {
  const chunkSize = 800;
  for (var i = 0; i < text.length; i += chunkSize) {
    print(
      text.substring(
        i,
        i + chunkSize > text.length ? text.length : i + chunkSize,
      ),
    );
  }
}

List<String>? castStringList(dynamic value) {
  if (value == null) return null;
  if (value is List<String>) return value;
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  return null;
}

bool canJoinCall(CountdownState state) {
  if (state.isFinished) return false;

  final totalMinutes =
      (state.days * 24 * 60) + (state.hours * 60) + state.minutes;

  return totalMinutes <= 5;
}

double averageRating(List<Review> reviews) {
  if (reviews.isEmpty) return 0.0;

  final validRatings = reviews
      .where((r) => r.rating != null)
      .map((r) => r.rating!);

  if (validRatings.isEmpty) return 0.0;

  final total = validRatings.reduce((a, b) => a + b);
  return total / validRatings.length;
}

IconData relatedModelTypeToIcon(RelatedModelType modelType) {
  switch (modelType) {
    case RelatedModelType.HIRED_JOB:
      return Icons.work_outline;
    case RelatedModelType.TRANSACTION:
      return Icons.payment;
    case RelatedModelType.DOCUMENT:
      return Icons.description_outlined;
    case RelatedModelType.ACCOUNT:
      return Icons.person_outline;
    case RelatedModelType.GENERAL:
      return Icons.help_outline;
    default:
      return Icons.help_outline;
  }
}

String relatedModelTypeToString(
  BuildContext context,
  RelatedModelType modelType,
) {
  final l10n = AppLocalizations.of(context)!;

  switch (modelType) {
    case RelatedModelType.HIRED_JOB:
      return l10n.relatedTypeHiredJobs;
    case RelatedModelType.TRANSACTION:
      return l10n.relatedTypeTransaction;
    case RelatedModelType.DOCUMENT:
      return l10n.relatedTypeDocument;
    case RelatedModelType.ACCOUNT:
      return l10n.relatedTypeAccount;
    case RelatedModelType.GENERAL:
      return l10n.relatedTypeGeneral;
    default:
      return "";
  }
}

class TicketStatusUI {
  final String name;
  final Color bgColor;

  const TicketStatusUI({
    required this.name,
    required this.bgColor,
  });
}

TicketStatusUI getTicketStatusUI(TicketStatus status) {
  switch (status) {
    case TicketStatus.OPEN:
      return const TicketStatusUI(
        name: 'Open',
        bgColor: Color(0xFF2563EB), // blue (100% opacity)
      );

    case TicketStatus.PENDING:
      return const TicketStatusUI(
        name: 'Pending',
        bgColor: Color(0xFFF59E0B), // amber (100% opacity)
      );

    case TicketStatus.RESOLVED:
      return const TicketStatusUI(
        name: 'Resolved',
        bgColor: Color(0xFF10B981), // green (100% opacity)
      );

    case TicketStatus.CLOSED:
      return const TicketStatusUI(
        name: 'Closed',
        bgColor: Color(0xFFEF4444), // red (100% opacity)
      );
  }
}
