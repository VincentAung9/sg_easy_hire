import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/providers/data_providers.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/repositories.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_up/sign_up_bloc.dart';
import 'package:sg_easy_hire/features/helper_auth/views/sign_up_view.dart';

class HelperSignUpPage extends StatelessWidget {
  const HelperSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(
        authRepository: AuthRepository(authProvider: AuthProvider()),
      ),
      child: const SignUpView(),
    );
  }
}
