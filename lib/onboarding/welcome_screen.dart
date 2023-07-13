import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/quotex_button.dart';
import 'package:quotex/quotex_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/preloader.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                      right: 16,
                      top: 92,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.welcome,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w700,
                      color: Color(QuotexColors.quotexWhiteCode),
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.weWillHelp,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w500,
                      color: Color(QuotexColors.quotexTextLightGreyCode),
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 42,
                    left: 16,
                    right: 16,
                  ),
                  child: Image.asset(
                    "assets/onboarding1.png",
                    width: 328,
                    height: 106,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: QuotexButton(
                text: AppLocalizations.of(context)!.continueButton,
                callback: () => {
                  Dependencies.instance.navigator.openAssetForTradingScreen()
                },
                textStyle: const TextStyle(
                  fontFamily: "Onest",
                  fontWeight: FontWeight.w700,
                  color: Color(QuotexColors.quotexWhiteCode),
                  fontSize: 16,
                ),
                buttonColor: const Color(QuotexColors.quotexGreenCode)),
          )
        ]),
      ),
    );
  }
}
