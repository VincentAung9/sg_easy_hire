import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/help_support/data/ticket_repository.dart';
import 'package:sg_easy_hire/features/help_support/domain/ticket_bloc/ticket_bloc.dart';
import 'package:sg_easy_hire/features/help_support/presentation/view/support_other_type_view.dart';

class SupportOtherTypePage extends StatelessWidget {
  const SupportOtherTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketBloc(TicketRepository()),
      child: const SupportOtherTypeView(),
    );
  }
}
