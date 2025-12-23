import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/core/domain/document_upload/document_upload_bloc.dart';
import 'package:sg_easy_hire/features/biodata/presentation/view/upload_document_view.dart';

class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentUploadBloc(),
      child: const UploadDocumentView(),
    );
  }
}
