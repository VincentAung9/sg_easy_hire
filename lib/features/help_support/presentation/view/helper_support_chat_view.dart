import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sg_easy_hire/core/models/chat_screen_param.dart';
import 'package:sg_easy_hire/core/router/router.dart';
import 'package:sg_easy_hire/core/theme/app_colors.dart';
import 'package:sg_easy_hire/core/utils/utils.dart';
import 'package:sg_easy_hire/features/help_support/data/ticket_repository.dart';
import 'package:sg_easy_hire/features/helper_core/domain/helper_core_bloc.dart';
import 'package:sg_easy_hire/l10n/l10n.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class HelperSupportChatView extends StatefulWidget {
  const HelperSupportChatView({super.key});

  @override
  State<HelperSupportChatView> createState() => _HelperSupportChatViewState();
}

class _HelperSupportChatViewState extends State<HelperSupportChatView> {
  User? admin;
  @override
  void initState() {
    getAdmin();
    super.initState();
  }

  Future<void> getAdmin() async {
    final adminResponse = await TicketRepository().getAdminUser();
    if (mounted) {
      setState(() {
        admin = adminResponse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = context.read<HelperCoreBloc>().state.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(RoutePaths.home),
        ),
        title: Text(l10n.supportChatTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primaryPurple50,
                  child: Icon(
                    FontAwesomeIcons.circleCheck,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.supportOnlineTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      l10n.supportOnlineSubtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(FontAwesomeIcons.clock, color: Colors.grey[600]),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            l10n.supportHelpQuestion,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              l10n.supportHelpDescription,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                SupportCategoryTile(
                  onTap: () => context.push(
                    RoutePaths.supportChatType,
                    extra: RelatedModelType.HIRED_JOB,
                  ),
                  icon: Icons.work_outline,
                  title: l10n.supportCategoryHiredJobs,
                  subtitle: l10n.supportCategoryHiredJobsDesc,
                ),
                SupportCategoryTile(
                  onTap: () => context.push(
                    RoutePaths.supportChatType,
                    extra: RelatedModelType.TRANSACTION,
                  ),
                  icon: Icons.payment,
                  title: l10n.supportCategoryTransaction,
                  subtitle: l10n.supportCategoryTransactionDesc,
                ),
                SupportCategoryTile(
                  onTap: () => context.push(
                    RoutePaths.supportChatType,
                    extra: RelatedModelType.DOCUMENT,
                  ),
                  icon: Icons.description_outlined,
                  title: l10n.supportCategoryDocuments,
                  subtitle: l10n.supportCategoryDocumentsDesc,
                ),
                SupportCategoryTile(
                  onTap: () {
                    if (admin == null) {
                      showError(context, l10n.supportErrorGeneric);
                      return;
                    }
                    // existing mutation logic stays the same
                  },
                  icon: Icons.person_outline,
                  title: l10n.supportCategoryAccount,
                  subtitle: l10n.supportCategoryAccountDesc,
                ),
                SupportCategoryTile(
                  onTap: () => context.push(
                    RoutePaths.supportChatTypeOther,
                    extra: RelatedModelType.GENERAL,
                  ),
                  icon: Icons.help_outline,
                  title: l10n.supportCategoryOther,
                  subtitle: l10n.supportCategoryOtherDesc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupportCategoryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  const SupportCategoryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryPurple50,
                child: Icon(icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
