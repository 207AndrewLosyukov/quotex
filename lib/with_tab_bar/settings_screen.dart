import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotex/main.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:quotex/with_tab_bar/trade/registration/sign_up.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 41.0),
          child: Text(
            AppLocalizations.of(context)!.settingsTitle,
            style: const TextStyle(
              fontFamily: "Onest",
              fontWeight: FontWeight.w700,
              color: Color(QuotexColors.quotexWhiteCode),
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 17.0),
          child: SizedBox(
            height: 56,
            child: InkWell(
              onTap: () => {
                privacyPolicyTapped(),
              },
              child: Row(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      "assets/privacy_policy.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 20,
                    child: Text(
                      AppLocalizations.of(context)!.privacyPolicy,
                      style: const TextStyle(
                        fontFamily: "Onest",
                        fontWeight: FontWeight.w400,
                        color: Color(QuotexColors.quotexWhiteCode),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      "assets/arrow.png",
                      height: 24,
                      width: 16,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(QuotexColors.quotexGreyTextCode),
        ),
        SizedBox(
          height: 56,
          child: InkWell(
            onTap: () => {
              termsOfServiceTapped(),
            },
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    "assets/terms_of_use.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 20,
                  child: Text(
                    AppLocalizations.of(context)!.termsOfUse,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w400,
                      color: Color(QuotexColors.quotexWhiteCode),
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    "assets/arrow.png",
                    height: 24,
                    width: 16,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(QuotexColors.quotexGreyTextCode),
        ),
        SizedBox(
          height: 56,
          child: InkWell(
            onTap: () => {
              showAlertDialog(
                context: context,
                title: AppLocalizations.of(context)!.deleteAlertTitle,
                content: "",
                cancelActionText: AppLocalizations.of(context)!.deleteAlertNo,
                defaultActionText: AppLocalizations.of(context)!.deleteAlertYes,
              ),
            },
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    "assets/delete.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 20,
                  child: Text(
                    AppLocalizations.of(context)!.deleteAccount,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w400,
                      color: Color(QuotexColors.quotexRedCode),
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(QuotexColors.quotexGreyTextCode),
        ),
      ]),
    );
  }

  void privacyPolicyTapped() async {
    Uri _url = Uri.parse(
        'https://docs.google.com/document/d/1GliHYxGVo5iw6WsR3rlaMCwwkDdPfYIVxaZ7CH_AUsY/edit?usp=sharing');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void termsOfServiceTapped() async {
    Uri _url = Uri.parse(
        'https://docs.google.com/document/d/14Cwve6NpCplLTEueJVKkaQcamCzhxeG3TF-my9lO9hM/edit?usp=sharing');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<Future> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String cancelActionText,
    required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
                child: Text(defaultActionText),
                onPressed: () => {
                      Navigator.of(context).pop(true),
                      Navigator.of(context).pop(true),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      ),
                      userDefault!.setBool("isRememberedAndSignUp", false),
                      userDefault!
                          .remove(userDefault!.getString("currentUser")!),
                      userDefault!.remove("currentUser"),
                      Hive.box('history').clear(),
                      Hive.box('balance').clear(),
                    }),
            ElevatedButton(
                child: Text(cancelActionText),
                onPressed: () => {
                      Navigator.of(context).pop(false),
                    }),
          ],
        ),
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: () => {
              Navigator.of(context).pop(true),
              Navigator.of(context).pop(true),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              ),
              userDefault!.setBool("isRememberedAndSignUp", false),
              userDefault!.remove(userDefault!.getString("currentUser")!),
              userDefault!.remove("currentUser"),
              Hive.box('history').clear(),
              Hive.box('balance').clear(),
            },
          ),
          CupertinoDialogAction(
            child: Text(
              cancelActionText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => {
              Navigator.of(context).pop(false),
            },
          ),
        ],
      ),
    );
  }
}
