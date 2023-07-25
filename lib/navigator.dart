import 'package:flutter/material.dart';
import 'package:quotex/onboarding/asset_for_trading_screen.dart';
import 'package:quotex/onboarding/identify_a_trend_screen.dart';
import 'package:quotex/onboarding/notification_screen.dart';
import 'package:quotex/onboarding/rate_screen.dart';
import 'package:quotex/onboarding/start_screen.dart';
import 'package:quotex/onboarding/trend_radar_screen.dart';
import 'package:quotex/onboarding/welcome_screen.dart';
import 'package:quotex/with_tab_bar/trade/registration/change_password_.dart';
import 'package:quotex/with_tab_bar/trade/registration/password_recovery_screen.dart';
import 'package:quotex/with_tab_bar/trade/registration/sign_in.dart';
import 'package:quotex/with_tab_bar/trade/registration/sign_up.dart';
import 'package:quotex/with_tab_bar/trade/trade_screen.dart';
import 'package:quotex/with_tab_bar/web_screen.dart';

class AppNavigator {
  // Глобальный навигатор
  static final navigatorKey = GlobalKey<NavigatorState>();

  openWelcomeScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );

  openAssetForTradingScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AssetForTradingScreen(),
        ),
      );

  openIdentifyATrendScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IdentifyATrendScreen(),
        ),
      );

  openTrendRadarScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TrendRadarScreen(),
        ),
      );

  openRateScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const RateScreen(),
        ),
      );

  openNotificationScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ),
      );

  openStartScreen() => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const StartScreen(),
        ),
      );

  openChangePasswordScreen(BuildContext buildContext) =>
      Navigator.of(buildContext, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ChangePasswordScreen(),
            maintainState: false),
      );

  openPasswordRecoveryScreen(BuildContext buildContext) =>
      Navigator.of(buildContext, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const PasswordRecoveryScreen(),
            maintainState: false),
      );

  openSignUpScreen(BuildContext buildContext) =>
      Navigator.of(buildContext, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const SignUpScreen(), maintainState: false),
      );

  openSignInScreen(BuildContext buildContext) =>
      Navigator.of(buildContext, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const SignInScreen(), maintainState: false),
      );

  openWebViewScreen(BuildContext buildContext) =>
      Navigator.of(buildContext, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
            builder: (context) => WebViewScreen(), maintainState: false),
      );

  openTradeScreen(BuildContext buildContext, balance) =>
      Navigator.of(buildContext, rootNavigator: false).pushReplacement(
        MaterialPageRoute(
            builder: (context) => TradeScreen(balance: balance),
            maintainState: false),
      );
}
