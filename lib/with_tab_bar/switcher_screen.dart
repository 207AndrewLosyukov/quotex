import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:quotex/with_tab_bar/history/history_screen.dart';

import 'package:quotex/with_tab_bar/settings_screen.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_cubit.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_screen.dart';
import 'package:quotex/with_tab_bar/trade/trade_screen.dart';

import '../main.dart';

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({Key? key}) : super(key: key);

  @override
  State<SwitcherScreen> createState() => SwitcherScreenState();
}

class SwitcherScreenState extends State<SwitcherScreen> {
  int currentTab = 0;

  Widget getData(index, context) {
    switch (index) {
      case 0:
        return FutureBuilder(
          future: Dependencies.instance.getBalance(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TradeScreen(
                balance: snapshot.data,
              );
            }
          },
        );
      case 1:
        return BlocProvider(
          create: (_) {
            return ScannerCubit(context);
          },
          child: const ScannerScreen(),
        );
      case 2:
        return HistoryScreen();
      default:
        return const SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.centerLeft,
        child: CupertinoTabScaffold(
          resizeToAvoidBottomInset: false,
          tabBar: CupertinoTabBar(
            onTap: (int n) => {setState(() {})},
            height: 52,
            backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
            activeColor: const Color(QuotexColors.quotexWhiteCode),
            inactiveColor: const Color(QuotexColors.quotexInactiveTabBarCode),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/inactive_trade.png",
                  height: 20,
                  width: 20,
                ),
                activeIcon: Image.asset(
                  "assets/active_trade.png",
                  height: 20,
                  width: 20,
                ),
                label: AppLocalizations.of(context)!.trade,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/inactive_scanner.png",
                  height: 20,
                  width: 20,
                ),
                activeIcon: Image.asset(
                  "assets/active_scanner.png",
                  height: 20,
                  width: 20,
                ),
                label: AppLocalizations.of(context)!.scanner,
              ),
              // if (userDefault!.getInt('status') == 0)
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/inactive_history.png",
                    height: 20,
                    width: 20,
                  ),
                  activeIcon: Image.asset(
                    "assets/active_history.png",
                    height: 20,
                    width: 20,
                  ),
                  label: AppLocalizations.of(context)!.history,
                ),
              // if (userDefault!.getInt('status') == 0)
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/inactive_settings.png",
                    height: 20,
                    width: 20,
                  ),
                  activeIcon: Image.asset(
                    "assets/active_settings.png",
                    height: 20,
                    width: 20,
                  ),
                  label: AppLocalizations.of(context)!.settings,
                ),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (context) {
                return getData(index, context);
              },
            );
          },
        ),
      ),
    );
  }
}
