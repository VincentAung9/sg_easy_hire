import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/providers/data_providers.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/auth_repository.dart';
import 'package:sg_easy_hire/features/auth/domain/verify_code/verify_code_bloc.dart';
import 'package:sg_easy_hire/features/auth/models/confirm_sign_up_param.dart';
import 'package:sg_easy_hire/features/verify_code/view/verify_code_view.dart';

class VerifyCodePage extends StatelessWidget {
  final ConfirmSignUpParam param;
  const VerifyCodePage({required this.param, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCodeBloc(
        authRepository: AuthRepository(authProvider: AuthProvider()),
      ),
      child: VerifyCodeView(param: param),
    );
  }
}
