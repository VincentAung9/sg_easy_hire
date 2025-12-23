import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/theme.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_bloc.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_event.dart';
import 'package:sg_easy_hire/features/biodata/domain/biodata_state.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_checkbox_item.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/form_footer.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/models/OtherPersonalInfo.dart';

class FoodHandlingView extends StatefulWidget {
  const FoodHandlingView({super.key});

  @override
  State<FoodHandlingView> createState() => _FoodHandlingViewState();
}

class _FoodHandlingViewState extends State<FoodHandlingView> {
  bool _handlePork = false;
  bool _eatPork = false;
  bool _handleBeef = false;
  bool _eatBeef = false;

  // State for accommodation preferences
  bool _shareRoom = false;
  bool _privateRoom = false;
  OtherPersonalInfo? oldData;

  bool checkEmpty() {
    return !_handlePork &&
        !_eatPork &&
        !_handleBeef &&
        !_eatBeef &&
        !_shareRoom &&
        !_privateRoom;
  }

  bool isFirstTimePressed = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isInitialized = false;

  @override
  void initState() {
    context.read<BiodataBloc>().add(GetOtherPersonalInfo());
    super.initState();
  }

  @override
  void dispose() {
    _handlePork = false;
    _eatPork = false;
    _handleBeef = false;
    _eatBeef = false;
    _shareRoom = false;
    _privateRoom = false;
    super.dispose();
  }

  void setInitialData(OtherPersonalInfo otherInfo) {
    isInitialized = true;
    oldData = otherInfo;
    for (String v in otherInfo.foodPreferences ?? []) {
      if (v.contains("handle")) {
        _handlePork = true;
      }
      if (v.contains("eat pork")) {
        _eatPork = true;
      }
      if (v.contains("handle beef")) {
        _handleBeef = true;
      }
      if (v.contains("eat beef")) {
        _eatBeef = true;
      }
    }
    for (String v in otherInfo.accommodationPreferences ?? []) {
      if (v.contains("share")) {
        _shareRoom = true;
      }
      if (v.contains("private")) {
        _privateRoom = true;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryLight),
          onPressed: () => context.go(RoutePaths.home),
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.4, // 10% for Step 1 of 10
                  backgroundColor: Colors.grey[300],
                  color: AppColors.primary,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Step 4 of 7",
              style: TextStyle(
                color: AppColors.textSecondaryLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        toolbarHeight: 60,
      ),

      body: BlocListener<BiodataBloc, BiodataState>(
        listener: (_, state) {
          if (state.action == BiodataStateAction.otherPersonalInfo &&
              state.status == BiodataStateStatus.success) {
            showSuccess(context, "Your information has been saved");
            context.go(RoutePaths.languagesSpoken);
          }
          if (state.action == BiodataStateAction.otherPersonalInfo &&
              state.status == BiodataStateStatus.saveDraftSuccess) {
            showSuccess(context, "Draft saved successfully");
          }
          if (state.action == BiodataStateAction.otherPersonalInfo &&
              state.status == BiodataStateStatus.failure) {
            showError(
              context,
              "Failed to save your information. Please try again.",
            );
          }
          if (!isInitialized && !(state.otherInfo == null)) {
            setInitialData(state.otherInfo!);
          }
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: AppColors.cardLight,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                13,
                              ), // Updated to avoid deprecated withOpacity
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Food Handling Preferences",
                              style: TextStyle(
                                color: AppColors.textPrimaryLight,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Select all that apply to you",
                              style: TextStyle(
                                color: AppColors.textSecondaryLight,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Column(
                              children: [
                                CustomCheckboxItem(
                                  label: "Able to handle pork",
                                  value: _handlePork,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _handlePork = newValue!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomCheckboxItem(
                                  label: "Able to eat pork",
                                  value: _eatPork,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _eatPork = newValue!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomCheckboxItem(
                                  label: "Able to handle beef",
                                  value: _handleBeef,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _handleBeef = newValue!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomCheckboxItem(
                                  label: "Able to eat beef",
                                  value: _eatBeef,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _eatBeef = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: AppColors.cardLight,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                13,
                              ), // Updated to avoid deprecated withOpacity
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Accommodation Preferences",
                              style: TextStyle(
                                color: AppColors.textPrimaryLight,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Select all that apply to you",
                              style: TextStyle(
                                color: AppColors.textSecondaryLight,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Column(
                              children: [
                                CustomCheckboxItem(
                                  label: "Willing to share a room",
                                  value: _shareRoom,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _shareRoom = newValue!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomCheckboxItem(
                                  label: "Prefer a private room",
                                  value: _privateRoom,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _privateRoom = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<BiodataBloc, BiodataState>(
        builder: (context, state) {
          return FormFooter(
            isNextLoading: state.status == BiodataStateStatus.loading,
            isSaveLoading: state.status == BiodataStateStatus.saveDraftLoading,
            onNext: () {
              if (checkEmpty()) {
                context.go(RoutePaths.languagesSpoken);
                return;
              } else {
                final data = getData();
                //save
                oldData == null
                    ? context.read<BiodataBloc>().add(
                        AddOtherPersonalInfo(data: data),
                      )
                    : //save
                      context.read<BiodataBloc>().add(
                        UpdateOtherPersonalInfo(data: data),
                      );
              }
            },
            onSave: () {
              if (checkEmpty()) {
                context.go(RoutePaths.languagesSpoken);
                return;
              } else {
                final data = getData();
                //save
                context.read<BiodataBloc>().add(
                  SaveDraftOtherPersonalInfo(data: data),
                );
              }
            },
          );
        },
      ),
    );
  }

  OtherPersonalInfo getData() {
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    List<String> foodPreferences = [];
    if (_handlePork) foodPreferences.add("Able to handle pork");
    if (_eatPork) foodPreferences.add("Able to eat pork");
    if (_handleBeef) foodPreferences.add("Able to handle beef");
    if (_eatBeef) foodPreferences.add("Able to eat beef");
    List<String> accommodationPreferences = [];
    if (_shareRoom) accommodationPreferences.add("Willing to share a room");
    if (_privateRoom) accommodationPreferences.add("Prefer a private room");
    return oldData == null
        ?
          //new
          OtherPersonalInfo(
            code: nanoid(),
            foodPreferences: foodPreferences,
            accommodationPreferences: accommodationPreferences,
            user: currentUser,
            isPublished: true,
            createdAt: TemporalDateTime(DateTime.now()),
          )
        :
          //old
          oldData!.copyWith(
            foodPreferences: foodPreferences,
            accommodationPreferences: accommodationPreferences,
            user: currentUser,
            isPublished: true,
            updatedAt: TemporalDateTime(DateTime.now()),
          );
  }
}
