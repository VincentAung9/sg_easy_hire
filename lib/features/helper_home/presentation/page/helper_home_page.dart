import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/domain/home_bloc/home_bloc.dart';
import 'package:sg_easy_hire/features/helper_home/presentation/view/helper_home_view.dart';
import 'package:sg_easy_hire/features/helper_home/repository/helper_home_repository.dart';

class HelperHomePage extends StatelessWidget {
  const HelperHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(repository: HelperHomeRepository()),
      child: const HelperHomeView(),
    );
  }
}
