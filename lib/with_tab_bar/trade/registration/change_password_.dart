import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var emailController = TextEditingController(text: "");
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
                padding: const EdgeInsets.only(top: 41.0, bottom: 29),
                child: Text(
                  AppLocalizations.of(context)!.signInTitle,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w500,
                    color: Color(QuotexColors.quotexWhiteCode),
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.toChangeYourPassword,
                style: const TextStyle(
                  fontFamily: "Onest",
                  fontWeight: FontWeight.w500,
                  color: Color(QuotexColors.quotexGreyRegistration),
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.email,
                        style: const TextStyle(
                          fontFamily: "Onest",
                          fontWeight: FontWeight.w500,
                          color: Color(QuotexColors.quotexWhiteCode),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: TextField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(QuotexColors.quotexGreenCode),
                          width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF4D5377), width: 1.0),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  autofocus: true,
                  onChanged: (value) => {},
                  onEditingComplete: () => {
                    FocusManager.instance.primaryFocus?.unfocus(),
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  maxLines: 1,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
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
                      Dependencies.instance.navigator
                          .openPasswordRecoveryScreen(context)
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
                          AppLocalizations.of(context)!.confirmEmail,
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
