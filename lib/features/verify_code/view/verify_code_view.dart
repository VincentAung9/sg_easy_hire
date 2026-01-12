import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/toast.dart';
import 'package:sg_easy_hire/core/widgets/widgets.dart';
import 'package:sg_easy_hire/features/auth/domain/verify_code/verify_code_bloc.dart';
import 'package:sg_easy_hire/features/auth/domain/verify_code/verify_code_event.dart';
import 'package:sg_easy_hire/features/auth/domain/verify_code/verify_code_state.dart';
import 'package:sg_easy_hire/features/auth/models/confirm_sign_up_param.dart';
import 'package:sg_easy_hire/features/auth/presentation/widgets/widgets.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/UserRole.dart';

class VerifyCodeView extends StatefulWidget {
  final ConfirmSignUpParam param;
  const VerifyCodeView({
    required this.param,
    super.key,
  });

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final pinController = TextEditingController();
  String error = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final verifyCodeBloc = context.read<VerifyCodeBloc>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- Top Logo & Header ---
                const Spacing(
                  height: 40,
                ),
                // --- Top Logo & Header ---
                LogoHeader(
                  title: widget.param.role == UserRole.EMPLOYER
                      ? t.employerApp
                      : t.helperApp,
                  subTitle: widget.param.role == UserRole.EMPLOYER
                      ? t.employerSubtitle
                      : t.helperSubtitle,
                ),
                const SizedBox(height: 48),
                FormCardContainer(
                  title: t.enterVerificationCode,
                  subTitle: t.verifyCodeSubtitle,
                  child: BlocConsumer<VerifyCodeBloc, VerifyCodeState>(
                    listener: (context, state) {
                      if (state.actions == VerifyActions.resendCode &&
                          state.status == VerifyStatus.failure) {
                        showError(
                          context,
                          t.resendOtpFailed,
                        );
                      }
                      if (state.actions == VerifyActions.verify &&
                          state.status == VerifyStatus.failure) {
                        showError(
                          context,
                          state.signUpReturnType?.error ?? "",
                        );
                      }
                      //if success
                      if (state.actions == VerifyActions.resendCode &&
                          state.status == VerifyStatus.success) {
                        showSuccess(
                          context,
                          t.resendOtpSuccess,
                        );
                      }
                      if (state.actions == VerifyActions.verify &&
                          state.status == VerifyStatus.success) {
                        showSuccess(
                          context,
                          t.verifySuccess,
                        );
                        context.go(
                          widget.param.role == UserRole.HELPER
                              ? RoutePaths.helperSignin
                              : RoutePaths.employerSignin,
                        );
                      }
                    },
                    builder: (_, state) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          // --- verification code ---
                          Pinput(
                            length: 6,
                            controller: pinController,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            validator: (s) {
                              if (s == null || s.isEmpty) {
                                return t.pinIncorrect;
                              } else {
                                return null;
                              }
                            },
                            errorTextStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                            onCompleted: (pin) =>
                                debugPrint("🔥 Pin Code: $pin"),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                t.dontReceiveOtp,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                onTap: () => verifyCodeBloc.add(
                                  ResendCodeEvent(phone: widget.param.phone),
                                ),
                                child:
                                    state.actions == VerifyActions.resendCode &&
                                        state.status == VerifyStatus.loading
                                    ? const ButtonLoading(
                                        color: AppColors.primary,
                                      )
                                    : Text(
                                        t.resendOtp,
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // --- Continue Button ---
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  verifyCodeBloc.add(
                                    PressVerifyCodeEvent(
                                      param: ConfirmSignUpParam(
                                        phone: widget.param.phone,
                                        code: pinController.text,
                                        fullName: widget.param.fullName,
                                        role: widget.param.role,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child:
                                  state.actions == VerifyActions.verify &&
                                      state.status == VerifyStatus.loading
                                  ? const ButtonLoading()
                                  : Text(t.verify),
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
      ),
    );
  }
}
