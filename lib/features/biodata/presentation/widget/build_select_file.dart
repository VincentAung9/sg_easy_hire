import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_bloc.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_state.dart';
import 'package:sg_easy_hire/core/models/app_document.dart';
import 'package:sg_easy_hire/core/theme/app_icons.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/fun.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';

class BuildSelectFile extends StatelessWidget {
  final bool show;
  final AppDocument? file;
  final void Function()? onRemove;
  const BuildSelectFile({
    required this.show,
    required this.file,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fileKEY = file == null ? null : fileKey(file!.file!);
    final extension = file == null ? "" : getFileExtension(file!.file!);
    return show
        ? BlocListener<DocumentUploadBloc, DocumentUploadState>(
            listenWhen: (previous, current) {
              if (previous != current) {
                return true;
              } else {
                return false;
              }
            },
            listener: (context, state) {
              debugPrint("🔥------Listener in component ");
              if (state.errorMap[fileKEY]?.isNotEmpty ?? false) {
                context.read<BiodataBloc>().add(
                  BroadcastFileUploadError(value: true),
                );
                showWarnning(
                  context,
                  "Some files can’t be uploaded. Try again.",
                );
              }
            },
            child: Container(
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
                                  file?.file?.name ?? "",
                                  style: TextStyle(color: Colors.grey.shade800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Text(
                                    file == null
                                        ? ""
                                        : formatFileSize(file!.file!.size),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  file?.url == null
                                      ? BlocBuilder<
                                          DocumentUploadBloc,
                                          DocumentUploadState
                                        >(
                                          builder: (context, state) {
                                            return (state
                                                        .errorMap[fileKEY]
                                                        ?.isNotEmpty ??
                                                    false)
                                                ? const Row(
                                                    spacing: 2,
                                                    children: [
                                                      Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        "Try again!",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : state.progressMap[fileKEY] ==
                                                      1
                                                ? const Row(
                                                    spacing: 2,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .circleCheck,
                                                        color: Colors.green,
                                                        size: 14,
                                                      ),
                                                      Text(
                                                        "Completed",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : (state.progressMap[fileKEY] ??
                                                          0) >
                                                      0
                                                ? const Text(
                                                    "Uploading",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                : const SizedBox();
                                          },
                                        )
                                      : const Text(
                                          "Origin",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                ],
                              ),
                              (file?.url == null)
                                  ? BlocBuilder<
                                      DocumentUploadBloc,
                                      DocumentUploadState
                                    >(
                                      builder: (context, state) {
                                        return ((state
                                                        .errorMap[fileKEY]
                                                        ?.isNotEmpty ??
                                                    false) &&
                                                (state.progressMap[fileKEY] ??
                                                        0) >
                                                    0)
                                            ? SizedBox(
                                                width: 140,
                                                height: 4,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8,
                                                      ),
                                                  child: LinearProgressIndicator(
                                                    value:
                                                        state
                                                            .progressMap[fileKEY] ??
                                                        0,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    color: Colors.green[500],
                                                    minHeight: 3,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox();
                                      },
                                    )
                                  : const SizedBox(),
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
            ),
          )
        : const SizedBox();
  }
}
