import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/preloader.dart';
import 'package:quotex/succesful/first_deposite_screen.dart';
import 'package:quotex/succesful/registration_successful_screen.dart';
import 'package:quotex/with_tab_bar/history/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

SharedPreferences? userDefault = null;

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryModelAdapter());
  await Hive.openBox('history');
  await Hive.openBox('balance');
  await Dependencies.instance.getHttpCurrencies();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("a73ce3b6-309d-4459-a926-1ebe27f8004b");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Dependencies.init();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      navigatorKey: AppNavigator.navigatorKey,
      home: const PreloaderScreen(),
    );
  }
}
