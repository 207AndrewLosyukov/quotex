import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/quotex_button.dart';
import 'package:quotex/quotex_colors.dart';

class FirstDepositeSuccesfulScreen extends StatelessWidget {
  const FirstDepositeSuccesfulScreen({super.key});

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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 100.0),
                child: Image.asset("assets/first_deposite.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: QuotexButton(
                  text: AppLocalizations.of(context)!.next,
                  callback: () => {},
                  textStyle: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w700,
                    color: Color(QuotexColors.quotexWhiteCode),
                    fontSize: 16,
                  ),
                  buttonColor: const Color(QuotexColors.quotexGreenCode)),
            )
          ],
        ),
      ),
    );
  }
}
