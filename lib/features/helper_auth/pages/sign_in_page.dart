import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/auth/data/providers/data_providers.dart';
import 'package:sg_easy_hire/features/auth/data/repositories/repositories.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_in/sign_in_bloc.dart';
import 'package:sg_easy_hire/features/helper_auth/views/sign_in_view.dart';

class HelperSignInPage extends StatelessWidget {
  const HelperSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(
        authRepository: AuthRepository(authProvider: AuthProvider()),
      ),
      child: const SignInView(),
    );
  }
}
