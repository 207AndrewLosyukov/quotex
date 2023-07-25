import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/quotex_button.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:quotex/with_tab_bar/trade/registration/sign_up.dart';

import '../with_tab_bar/switcher_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/preloader.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 232.0,
              left: 27.0,
              right: 27.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/onboarding10.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Column(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 92,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.startWith,
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
                      AppLocalizations.of(context)!.tryTrading,
                      style: const TextStyle(
                        fontFamily: "Onest",
                        fontWeight: FontWeight.w500,
                        color: Color(QuotexColors.quotexTextLightGreyCode),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: QuotexButton(
                  text: AppLocalizations.of(context)!.continueButton,
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
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
        ],
      ),
    );
  }
}
