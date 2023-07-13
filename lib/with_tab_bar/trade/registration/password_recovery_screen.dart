import 'package:flutter/material.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  // чтобы 2 раза сбросить фокус при прогрузке экрана
  int didInitialized = 0;

  @override
  Widget build(BuildContext context) {
    if (didInitialized < 2) {
      FocusScope.of(context).unfocus();
      didInitialized++;
    }
    return Scaffold(
      backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 215.0),
                  child: Image.asset(
                    "assets/password_recovery.png",
                    height: 124,
                    width: 124,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  AppLocalizations.of(context)!.passwordRecovery,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w700,
                    color: Color(QuotexColors.quotexWhiteCode),
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.checkYourEmail,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w500,
                    color: Color(QuotexColors.quotexGreyRegistration),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () => {
                      // if (userDefault!.getInt('status') == 1)
                      //   {
                      //     Dependencies.instance.navigator
                      //         .openWebViewScreen(context),
                      //   }
                      // else
                      //   {
                      //     FutureBuilder(
                      //       future: Dependencies.instance.getBalance(),
                      //       builder: (BuildContext context,
                      //           AsyncSnapshot<dynamic> snapshot) {
                      //         if (!snapshot.hasData) {
                      //           // return const Center(
                      //           //   child: CircularProgressIndicator(),
                      //           // );
                      //         } else {
                      //           Dependencies.instance.navigator
                      //               .openTradeScreen(context, snapshot.data);
                      //         }
                      //       },
                      //     )
                      //   }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(QuotexColors.quotexGreenCode),
                      ),
                      width: 312,
                      height: 56,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.done,
                          style: const TextStyle(
                            fontFamily: "Onest",
                            fontWeight: FontWeight.w700,
                            color: Color(
                              QuotexColors.quotexWhiteCode,
                            ),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
