import 'dart:async';
import 'dart:developer';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sg_easy_hire/amplifyconfiguration.dart';
import 'package:sg_easy_hire/models/ModelProvider.dart';
import 'package:cached_query/cached_query.dart';
import 'package:cached_storage/cached_storage.dart';

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
  CachedQuery.instance.config(
    storage: await CachedStorage.ensureInitialized(),
    config: const GlobalQueryConfig(
      staleDuration: Duration(minutes: 5),
      cacheDuration: Duration(minutes: 5),
    ),
  );
  await _initHiveBox();

  await _configureAmplify(); /* 
  await Amplify.DataStore.clear(); // Wipes the local SQLite cache */
  runApp(await builder());
}

Future<void> _initHiveBox() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  Hive.registerAdapter<User>(
    'HiveUser',
    (dynamic v) =>
        v == null ? null : User.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<UploadedDocuments>(
    'UploadedDocuments',
    (dynamic v) => v == null
        ? null
        : UploadedDocuments.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<PersonalInformation>(
    'PersonalInformations',
    (dynamic v) => v == null
        ? null
        : PersonalInformation.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<ContactFamilyDetails>(
    'ContactFamilyDetails',
    (dynamic v) => v == null
        ? null
        : ContactFamilyDetails.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<MedicalHistory>(
    'MedicalHistory',
    (dynamic v) => v == null
        ? null
        : MedicalHistory.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<OtherPersonalInfo>(
    'OtherPersonalInfo',
    (dynamic v) => v == null
        ? null
        : OtherPersonalInfo.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<JobPreferences>(
    'JobPreferences',
    (dynamic v) => v == null
        ? null
        : JobPreferences.fromJson(Map<String, dynamic>.from(v as Map)),
  );
  Hive.registerAdapter<List<WorkHistory>>(
    'WorkHistory',
    (dynamic v) => v == null
        ? null
        : [WorkHistory.fromJson(Map<String, dynamic>.from(v as Map))],
  );
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    final api = AmplifyAPI(
      options: APIPluginOptions(modelProvider: ModelProvider.instance),
    );
    /*  final datastorePlugin = AmplifyDataStore(
      modelProvider: ModelProvider.instance,
    ); */
    final pushPlugin = AmplifyPushNotificationsPinpoint()
      ..onNotificationReceivedInBackground(
        myAsyncNotificationReceivedHandler,
      );

    await Amplify.addPlugins([
      auth,
      api,
      /* datastorePlugin, */ storage,
      pushPlugin,
    ]);

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
