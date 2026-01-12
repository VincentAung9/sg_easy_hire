import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sg_easy_hire/core/constants/constants.dart';
import 'package:sg_easy_hire/features/biodata/domain/work_history_cubic.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_form_dropdown.dart';
import 'package:sg_easy_hire/features/biodata/presentation/widget/custom_text_field.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class WorkExperienceForm extends StatefulWidget {
  const WorkExperienceForm({super.key});

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  bool isFirstTimePressed = false;
  String? location;
  TextEditingController durationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dutiesController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    durationController.dispose();
    descriptionController.dispose();
    dutiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return CustomFormDropDown(
                  label: t.location,
                  placeholder: t.selectCountry,
                  isRequired: true,
                  isFirstTimePressed: isFirstTimePressed,
                  initialValue: location,
                  items: countries,
                  onChanged: (newValue) {
                    if (!(newValue == null)) {
                      setState(() {
                        location = newValue;
                      });
                    }
                  },
                );
              },
            ),

            /* _buildTextField(
                                            initialValue: workHistory.location,
                                            label: "Location", 
                                            placeholder: "Singapore", 
                                            onChanged: (v) => context.read<WorkHistoryCubit>().changeLocation(index, v),
                                            ), */
            const SizedBox(height: 16),
            CustomTextField(
              controller: durationController,
              label: t.duration,
              placeholder: t.durationPlaceholder,
              isFirstTimePressed: isFirstTimePressed,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: descriptionController,
              label: t.description,
              placeholder: t.descriptionPlaceholder,
              isFirstTimePressed: isFirstTimePressed,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: dutiesController,
              label: t.duties,
              placeholder: t.dutiesPlaceholder,
              isFirstTimePressed: isFirstTimePressed,
              isRequired: true,
            ),
            const SizedBox(height: 6),
            Align(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFirstTimePressed = true;
                  });
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<WorkHistoryCubit>().addWorkHistory(
                      WorkHistory(
                        code: nanoid(10),
                        createdAt: TemporalDateTime(DateTime.now()),
                        location: location,
                        description: descriptionController.text,
                        duration: durationController.text,
                        duties: dutiesController.text,
                        helper: currentUser,
                      ),
                    );
                    setState(() {
                      isFirstTimePressed = false;
                      location = null;
                      descriptionController.clear();
                      durationController.clear();
                      dutiesController.clear();
                    });
                  }
                },
                child: Text(
                  t.addWorkHistory,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
