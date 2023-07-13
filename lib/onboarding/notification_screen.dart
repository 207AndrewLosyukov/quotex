import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/quotex_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
              top: 226.0,
              right: 10.0,
              left: 10.0,
            ),
            child: SizedBox.expand(
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment(0, -0.4),
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/onboarding9.png',
                  height: 400,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 92,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.pushNotification,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w700,
                      color: Color(QuotexColors.quotexWhiteCode),
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: QuotexButton(
                    text: AppLocalizations.of(context)!.continueButton,
                    callback: () {
                      OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
                        print("Accepted permission: $accepted");
                      });

                      Dependencies.instance.navigator.openStartScreen();
                    },
                    textStyle: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w700,
                      color: Color(QuotexColors.quotexWhiteCode),
                      fontSize: 16,
                    ),
                    buttonColor: const Color(QuotexColors.quotexGreenCode)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
