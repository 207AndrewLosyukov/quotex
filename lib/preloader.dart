import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotex/with_tab_bar/switcher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dependencies.dart';
import 'main.dart';

class PreloaderScreen extends StatefulWidget {
  const PreloaderScreen({super.key});

  @override
  State<PreloaderScreen> createState() => _PreloaderScreenState();
}

class _PreloaderScreenState extends State<PreloaderScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setUserDefaults(),
      builder: (context, data) {
        if (data.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _navFunc());
          return const Scaffold();
        }

        return Scaffold(
          body: Stack(children: [
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
                top: 241,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/logo.png",
                    width: 120,
                    height: 158,
                  ),
                  const Spacer()
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  Future<String> setUserDefaults() async {
    userDefault = await SharedPreferences.getInstance();
    Uri linkUrl = Uri.parse('http://terms.qx-data.com/link?version=1');
    await http.get(linkUrl).then((response) {
      userDefault!.setString('link', response.body);
    });
    Uri url = Uri.parse('http://terms.qx-data.com/status?version=1');
    final response = await http.get(url);
    if (response.body == "1") {
      userDefault!.setInt('status', 1);
    } else {
      userDefault!.setInt('status', 0);
    }
    return response.body;
  }

  _navFunc() {
    if (userDefault!.getBool('onboarding') == null) {
      userDefault!.setBool('onboarding', true);
      Dependencies.instance.navigator.openWelcomeScreen();
    } else {
      if (userDefault!.getBool('isRememberedAndSignUp') == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SwitcherScreen()),
        );
      } else {
        Dependencies.instance.navigator.openSignUpScreen(context);
      }
    }
  }
}
