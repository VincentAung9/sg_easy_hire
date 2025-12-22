import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sg_easy_hire/core/theme/app_icons.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';

class BuildSelectFile extends StatelessWidget {
  final bool show;
  final PlatformFile? file;
  final void Function()? onRemove;
  const BuildSelectFile({
    required this.show,
    required this.file,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final extension = file == null ? "" : getFileExtension(file!);
    return show
        ? Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundLight,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2), // x, y
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      (extension?.contains('pdf') ?? false)
                          ? AppIcons.pdf
                          : (extension?.contains("mp4") ?? false) ||
                                (extension?.contains("mov") ?? false)
                          ? AppIcons.video
                          : AppIcons.image,
                      height: 35,
                      width: 35,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Builder(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 3,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                file?.name ?? "",
                                style: TextStyle(color: Colors.grey.shade800),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              file == null ? "" : formatFileSize(file!.size),
                              style: TextStyle(color: Colors.grey.shade600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                InkWell(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 14,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
