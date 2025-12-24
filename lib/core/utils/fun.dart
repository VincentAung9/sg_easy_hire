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
import 'package:sg_easy_hire/models/ChatStatus.dart';
import 'package:sg_easy_hire/models/InterviewStatus.dart';
import 'package:sg_easy_hire/models/JobOfferStatus.dart';
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

InterviewStatusUI getInterviewStatusUI(InterviewStatus status) {
  switch (status) {
    case InterviewStatus.PENDING:
      return InterviewStatusUI(
        text: "Pending",
        icon: Icons.schedule,
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
      );

    case InterviewStatus.ACCEPTED:
      return InterviewStatusUI(
        text: "Confirmed",
        icon: Icons.check_circle,
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFD1FAE5),
      );

    case InterviewStatus.COMPLETED:
      return InterviewStatusUI(
        text: "Completed",
        icon: Icons.check,
        color: const Color(0xFF3B82F6),
        bgColor: const Color(0xFFDBEAFE),
      );

    case InterviewStatus.CANCELLED:
      return InterviewStatusUI(
        text: "Cancelled",
        icon: Icons.cancel,
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      );

    case InterviewStatus.NO_SHOW:
      return InterviewStatusUI(
        text: "Completed",
        icon: Icons.check,
        color: const Color(0xFF3B82F6),
        bgColor: const Color(0xFFDBEAFE),
      );
    case InterviewStatus.PROCESSING:
      return InterviewStatusUI(
        text: 'Interviewing',
        icon: Icons.hourglass_top,
        color: const Color(0xFFF59E0B), // amber
        bgColor: const Color(0xFFFEF3C7),
      );
  }
}

ProfileStatusUI getProfileStatus(VerifyStatus status) {
  switch (status) {
    case VerifyStatus.PENDING:
      return ProfileStatusUI(
        text: "Profile Pending",
        description: "Admin is checking your biodata",
        icon: Icons.schedule,
        color: const Color(0xFFF59E0B), // amber
        bgColor: const Color(0xFFFEF3C7).withOpacity(0.12),
      );

    case VerifyStatus.VERIFIED:
      return ProfileStatusUI(
        text: "Profile Approved",
        description: "Your profile has been approved",
        icon: Icons.check_circle,
        color: const Color(0xFF16A34A), // green
        bgColor: const Color(0xFFDCFCE7).withOpacity(0.12),
      );

    case VerifyStatus.UNVERIFIED:
      return ProfileStatusUI(
        text: "Profile Rejected",
        description: "Your profile was rejected. Please update your biodata",
        icon: Icons.cancel,
        color: const Color(0xFFDC2626), // red
        bgColor: const Color(0xFFFEE2E2).withOpacity(0.12),
      );
  }
}

InterviewStatusUI getOfferedJobStatusUI(JobOfferStatus status) {
  switch (status) {
    case JobOfferStatus.PENDING:
      return InterviewStatusUI(
        text: "Pending",
        icon: Icons.schedule,
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
      );

    case JobOfferStatus.ACCEPTED:
      return InterviewStatusUI(
        text: "Accepted",
        icon: Icons.check_circle,
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFD1FAE5),
      );

    case JobOfferStatus.CANCELLED:
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
  final formatMethod = DateFormat.yMd().add_jm();
  final date = temporalDateTime.getDateTimeInUtc().toLocal();
  return formatMethod.format(date);
}

String timeAgo(TemporalDateTime temporalDateTime) {
  final date = temporalDateTime.getDateTimeInUtc().toLocal();
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inSeconds < 60) {
    return "just now";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago";
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

Map<String, dynamic> getInterviewAction(InterviewStatus status) {
  switch (status) {
    case InterviewStatus.PENDING:
      return {
        "text": "Accept",
        "bgColor": Colors.green[100],
        "fgColor": Colors.green[600],
      };

    case InterviewStatus.ACCEPTED:
      return {
        "text": "Cancel",
        "bgColor": Colors.red[100],
        "fgColor": Colors.red[500],
      };

    case InterviewStatus.COMPLETED:
      return {
        "text": "Completed",
        "bgColor": Colors.grey[200],
        "fgColor": Colors.grey[600],
      };

    case InterviewStatus.CANCELLED:
      return {
        "text": "Cancelled",
        "bgColor": Colors.grey[300],
        "fgColor": Colors.grey[700],
      };

    case InterviewStatus.NO_SHOW:
      return {
        "text": "No Show",
        "bgColor": Colors.grey[300],
        "fgColor": Colors.grey[700],
      };
    case InterviewStatus.PROCESSING:
      return {
        "text": "Interviewing",
        "bgColor": Colors.grey[300],
        "fgColor": Colors.grey[700],
      };
  }
}

Future<TemporalDateTime?> showInterviewDateDialog(
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
    width: radius,
    height: radius,
    // Slight translucent white border behind avatar to match original look
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 0.2),
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: ClipOval(
      child: CircleAvatar(
        radius: radius / 2,
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
