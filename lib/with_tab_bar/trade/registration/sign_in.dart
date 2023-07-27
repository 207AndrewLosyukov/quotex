import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/main.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/with_tab_bar/switcher_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isTapped = false;
  var emailController = TextEditingController(text: "");
  var passwordController = TextEditingController(text: "");
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
              Row(
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
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.password,
                        textAlign: TextAlign.left,
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
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    InkWell(
                      child: isTapped
                          ? const Icon(
                              Icons.check_box_rounded,
                              size: 24.0,
                              color: Color(QuotexColors.quotexGreenCode),
                            )
                          : Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: const Color(
                                        QuotexColors.quotexGreyRegistration)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                      onTap: () {
                        setState(
                          () => isTapped = !isTapped,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        AppLocalizations.of(context)!.rememberMe,
                        style: const TextStyle(
                          fontFamily: "Onest",
                          fontWeight: FontWeight.w500,
                          color: Color(QuotexColors.quotexHistoryGreyCode),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                InkWell(
                  onTap: () => {
                    userDefault!.setBool("isRememberedAndSignUp", isTapped),
                    if (userDefault!.containsKey(emailController.text))
                      {
                        if (userDefault!.get(emailController.text) == passwordController.text)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SwitcherScreen()),
                            )
                          }
                      }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(QuotexColors.quotexGreenCode)),
                    width: 312,
                    height: 56,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.signIn,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 9.5,
                    bottom: 30,
                  ),
                  child: InkWell(
                    onTap: () => {
                      Dependencies.instance.navigator.openSignUpScreen(context),
                    },
                    child: Text(
                      AppLocalizations.of(context)!.registration,
                      style: const TextStyle(
                        fontFamily: "Onest",
                        fontWeight: FontWeight.w700,
                        color: Color(
                          QuotexColors.quotexGreenCode,
                        ),
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
