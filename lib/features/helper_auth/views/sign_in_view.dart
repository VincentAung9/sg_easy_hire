import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/constants/country_codes.dart';
import 'package:sg_easy_hire/core/localization/presentation/language_switch_component.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/widgets/input_error.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/auth/domain/sign_in/sign_in.dart';
import 'package:sg_easy_hire/features/auth/models/sign_in_param.dart';
import 'package:sg_easy_hire/features/auth/presentation/widgets/widgets.dart';
import 'package:sg_easy_hire/l10n/gen/app_localizations.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CountryCode _selectedCountryCode = const CountryCode(
    code: '+95',
    flag: '🇲🇲',
  );
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
    phoneError = "";
    passwordError = "";
    setState(() {});
  }

  bool _isValid() {
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
    final signInBloc = context.read<SignInBloc>();
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
              const Align(
                alignment: Alignment.topRight,
                child: LanguageSwitchComponent(),
              ),
              // --- Top Logo & Header ---
              LogoHeader(
                title: t.appTitle,
                subTitle: t.appSubtitle,
              ),
              const SizedBox(height: 48),

              // --- White Card Container ---
              FormCardContainer(
                title: t.welcomeBack,
                subTitle: t.signInSubtitle,
                child: BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    safePrint(
                      "🌈 ${state.signInReturnType?.result.toString()}\n${state.signInReturnType?.error}",
                    );
                    if (state.status == SignInStatus.success &&
                        state.action == SignInActions.resendCode) {
                      //resendCode success
                      /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VerificationConfirmCode(
                                  role: UserRole.HELPER,
                                  phone:
                                      "$_selectedCountryCode${_phoneController.text}",
                                  fullName: _fullNameController.text,
                                ),
                              ),
                            ); */
                    }
                    if (state.status == SignInStatus.success &&
                        state.action == SignInActions.signin) {
                      //subscribe to user
                      context.go(RoutePaths.onboardingBiodata);
                      /* context.read<HelperCoreBloc>().add(
                        StartSubscribeToUser(),
                      );
                      context.go(RoutePaths.home); */
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputError(
                          isError: state.status == SignInStatus.needCodeRequest,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '*${state.requestCodeMessage}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  signInBloc.add(
                                    SignInResendCodeEvent(
                                      phone:
                                          '$_selectedCountryCode${_phoneController.text}',
                                    ),
                                  );
                                },

                                child:
                                    state.status == SignInStatus.loading &&
                                        state.action == SignInActions.resendCode
                                    ? const ButtonLoading()
                                    : const Text(
                                        "Resend code",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        InputError(
                          isError:
                              state.status == SignInStatus.failure ||
                              (state.signInReturnType?.error?.isNotEmpty ??
                                  false),
                          error: '*${state.signInReturnType?.error}',
                        ),

                        const SizedBox(height: 20),

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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Phone number is required";
                                    } else {
                                      return null;
                                    }
                                  },
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
                        BlocBuilder<SignInBloc, SignInState>(
                          builder: (_, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  resetState();
                                  if (_isValid()) {
                                    context.read<SignInBloc>().add(
                                      SignInPressEvent(
                                        signInParam: SignInParam(
                                          phone: _phoneController.text,
                                          password: _passwordController.text,
                                          role: UserRole.HELPER,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child:
                                    state.action == SignInActions.signin &&
                                        state.status == SignInStatus.loading
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
                                text: "${t.noAccount} ",
                                style: theme.textTheme.titleSmall,
                                children: [
                                  TextSpan(
                                    text: t.signUp,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        safePrint("🔥 on tap...");
                                        context.go(
                                          RoutePaths.helperRegister,
                                        );
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
