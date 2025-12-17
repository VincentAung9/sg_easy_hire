import 'dart:async';
import 'dart:developer';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sg_easy_hire/amplifyconfiguration.dart';
import 'package:sg_easy_hire/core/constants/box_keys.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  Hive.registerAdapter<User>(
    'HiveUser',
    (dynamic v) =>
        v == null ? null : User.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  // ignore: inference_failure_on_function_invocation
  Hive.box<User>(name: userBox);
  // ignore: inference_failure_on_function_invocation
  Hive.box<bool>(name: signInBox);

  await _configureAmplify(); /* 
  await Amplify.DataStore.clear(); // Wipes the local SQLite cache */
  runApp(await builder());
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    final api = AmplifyAPI(
      options: APIPluginOptions(modelProvider: ModelProvider.instance),
    );
    final datastorePlugin = AmplifyDataStore(
      modelProvider: ModelProvider.instance,
    );
    final pushPlugin = AmplifyPushNotificationsPinpoint()
      ..onNotificationReceivedInBackground(
        myAsyncNotificationReceivedHandler,
      );

    await Amplify.addPlugins([auth, api, datastorePlugin, storage, pushPlugin]);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('🌈  An error occurred configuring Amplify: $e');
  }
}

Future<void> myAsyncNotificationReceivedHandler(
  PushNotificationMessage notification,
) async {
  // Process the received push notification message in the background
}
