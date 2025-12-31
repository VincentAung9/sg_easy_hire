import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/constants/country_codes.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_up/sign_up_bloc.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_up/sign_up_event.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_up/sign_up_state.dart';
import 'package:sg_easy_hire/features/auth/models/confirm_sign_up_param.dart';
import 'package:sg_easy_hire/features/auth/models/sign_up_param.dart';
import 'package:sg_easy_hire/features/auth/presentation/widgets/widgets.dart';
import 'package:sg_easy_hire/l10n/gen/app_localizations.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CountryCode _selectedCountryCode = const CountryCode(
    code: '+95',
    flag: '🇲🇲',
  );

  String fullNameError = "";
  String phoneError = "";
  String passwordError = "";
  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void resetState() {
    fullNameError = "";
    phoneError = "";
    passwordError = "";
    setState(() {});
  }

  bool _isValid() {
    if (_fullNameController.text.isEmpty) {
      fullNameError = "Full name is required";
      setState(() {});
      return false;
    }
    if (_phoneController.text.isEmpty) {
      phoneError = "Phone number is required";
      setState(() {});
      return false;
    }
    if (_passwordController.text.isEmpty) {
      passwordError = "Password is required";
      setState(() {});
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacing(
                height: 40,
              ),
              // --- Top Logo & Header ---
              LogoHeader(
                title: t.appTitle,
                subTitle: t.signUpSubtitle,
              ),
              const SizedBox(height: 48),

              // --- White Card Container ---
              FormCardContainer(
                title: t.createAccountTitle,
                subTitle: t.createAccountSubtitle,
                child: BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state.isSuccess ||
                        (state.signUpReturnType?.result?.isSignUpComplete ??
                            false)) {
                      context.go(
                        RoutePaths.verifyCode,
                        extra: ConfirmSignUpParam(
                          phone: _phoneController.text,
                          code: "",
                          fullName: _fullNameController.text,
                          role: UserRole.HELPER,
                        ),
                      );
                      return;
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputError(
                          isError:
                              state.isError ||
                              (state.signUpReturnType?.error?.isNotEmpty ??
                                  false),
                          error: "*${state.signUpReturnType?.error}",
                        ),

                        const SizedBox(height: 20),
                        Text(
                          t.fullNameLabel,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _fullNameController,
                          decoration: AppInputDecoration.auth(
                            placeholder: t.fullNameHint,
                          ),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                        InputError(
                          isError: fullNameError.isNotEmpty,
                          error: fullNameError,
                        ),
                        const SizedBox(height: 24),
                        // --- Phone Number ---
                        Text(
                          t.phoneNumber,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 52,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CountryCodeDropdown(
                                onChanged: (v) => setState(() {
                                  _selectedCountryCode = v;
                                }),
                                selectedCountryCode: _selectedCountryCode,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _phoneController,

                                  decoration: AppInputDecoration.phone(
                                    placeholder: '8123 4567',
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InputError(
                          isError: phoneError.isNotEmpty,
                          error: phoneError,
                        ),
                        const SizedBox(height: 24),
                        // --- Password ---
                        Text(t.password, style: theme.textTheme.titleSmall),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          decoration: AppInputDecoration.auth(
                            placeholder: t.enterPassword,
                          ),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty == true) {
                              return "Password is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        InputError(
                          isError: passwordError.isNotEmpty,
                          error: passwordError,
                        ),
                        const SizedBox(height: 24),
                        // --- Continue Button ---
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (_, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  resetState();
                                  if (_isValid()) {
                                    signUpBloc.add(
                                      SignUpPressEvent(
                                        param: SignUpParam(
                                          fullName: _fullNameController.text,
                                          phone: _phoneController.text,
                                          password: _passwordController.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: state.isPending
                                    ? const ButtonLoading()
                                    : Text(
                                        "Continue",
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                              ),
                            );
                          },
                        ),
                        // --- Sign In Link ---
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Already have an account?",
                                style: theme.textTheme.titleSmall,
                                children: [
                                  TextSpan(
                                    text: ' Sign In',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        safePrint("🔥 on tap...");
                                        context.go(RoutePaths.helperSignin);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
