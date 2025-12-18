import 'package:flutter/widgets.dart';
import 'package:sg_easy_hire/features/helper_interview/presentation/view/helper_interviews_view.dart';

class HelperInterviewsPage extends StatelessWidget {
  final String status;
  const HelperInterviewsPage({
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HelperInterviewsView(
      status: status,
    );
  }
}
