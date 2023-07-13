import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:quotex/small_button.dart';
import 'package:quotex/with_tab_bar/history/history_model.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradeScreen extends StatefulWidget {
  final int balance;
  const TradeScreen({super.key, required this.balance});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  late WebViewController _webViewController;
  String htmlData = "";
  late int balance = widget.balance;
  int investment = 1000;

  int xCoord = 1;
  int yCoord = 1;

  var pc = PanelController();
  String currTradeValue = "EUR/USD";
  int isJustInitialized = 0;

  @override
  Widget build(BuildContext context) {
    if (isJustInitialized < 2) {
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      isJustInitialized++;
    }
    var investmentController = TextEditingController(text: "\$$investment");
    var balanceController = TextEditingController(
      text: balance.toString(),
    );
    htmlData = getHtml(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.width - 50.0,
        currTradeValue.replaceFirst("/", "")
    );
    return Scaffold(
      backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
      body: SlidingUpPanel(
        controller: pc,
        slideDirection: SlideDirection.DOWN,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height - 52,
        panel: Container(
          color: const Color(
            QuotexColors.quotexBackgroundCode,
          ),
          height: MediaQuery.of(context).size.height - 52,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 41.0),
                child: InkWell(
                  onTap: () {
                    pc.close();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currTradeValue,
                        style: const TextStyle(
                          fontFamily: "Onest",
                          fontWeight: FontWeight.w700,
                          color: Color(QuotexColors.quotexWhiteCode),
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Image.asset(
                          "assets/down_arrow.png",
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 41.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 191,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: 11 / 812 * MediaQuery.of(context).size.height),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 11.0,
                        ),
                        child: Row(
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Expanded(
                              flex: 22,
                              child: ScannerButton(
                                activeButtonColor:
                                    const Color(QuotexColors.quotexGreenCode),
                                text: getTableString(context)[index][0],
                                callback: () => {
                                  setState(() {
                                    xCoord = 0;
                                    yCoord = index;
                                    currTradeValue =
                                        getTableString(context)[index][0];
                                  }),
                                  htmlData = getHtml(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.width - 50.0,
                                      currTradeValue.replaceFirst("/", "")
                                  ),
                                  _loadHtmlFromAssets(),
                                  pc.close()
                                },
                                isActive: xCoord == 0 && yCoord == index
                                    ? true
                                    : false,
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Expanded(
                              flex: 22,
                              child: ScannerButton(
                                activeButtonColor: const Color(
                                  QuotexColors.quotexGreenCode,
                                ),
                                text: getTableString(context)[index][1],
                                callback: () => {
                                  setState(() {
                                    xCoord = 1;
                                    yCoord = index;
                                    currTradeValue =
                                        getTableString(context)[index][1];
                                  }),
                                  htmlData = getHtml(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.width - 50.0,
                                      currTradeValue.replaceFirst("/", "")
                                  ),
                                  _loadHtmlFromAssets(),
                                  pc.close()
                                },
                                isActive: xCoord == 1 && yCoord == index
                                    ? true
                                    : false,
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Expanded(
                              flex: 22,
                              child: ScannerButton(
                                activeButtonColor:
                                    const Color(QuotexColors.quotexGreenCode),
                                text: getTableString(context)[index][2],
                                callback: () => {
                                  setState(() {
                                    xCoord = 2;
                                    yCoord = index;
                                    currTradeValue =
                                        getTableString(context)[index][2];
                                  }),
                                  htmlData = getHtml(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.width - 50.0,
                                      currTradeValue.replaceFirst("/", "")
                                  ),
                                  _loadHtmlFromAssets(),
                                  pc.close()
                                },
                                isActive: xCoord == 2 && yCoord == index
                                    ? true
                                    : false,
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 41.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          pc.open();
                        },
                        child: Row(
                          children: [
                            Text(
                              currTradeValue,
                              style: const TextStyle(
                                fontFamily: "Onest",
                                fontWeight: FontWeight.w700,
                                color: Color(QuotexColors.quotexWhiteCode),
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                "assets/down_arrow.png",
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top:
                                  42 / 812 * MediaQuery.of(context).size.height,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                                child: WebView(
                                  initialUrl: '',
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onWebViewCreated: (WebViewController webViewController) {
                                    _webViewController = webViewController;
                                    _loadHtmlFromAssets();
                                  },
                                ),
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              children: [
                                const Spacer(),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // первая колонка снизу
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Container(
                                                  width: 156,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      QuotexColors
                                                          .quotexBackgroundCode,
                                                    ),
                                                    border: Border.all(
                                                      color: const Color(
                                                        QuotexColors
                                                            .quotexGreyTextCode,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10.0,
                                                              top: 10.0,
                                                            ),
                                                            child: InkWell(
                                                              onTap: () => {
                                                                setState(
                                                                  () {
                                                                    if (balance >
                                                                        0.0) {
                                                                      balance -=
                                                                          1;
                                                                    }
                                                                  },
                                                                ),
                                                                Dependencies
                                                                    .instance
                                                                    .saveBalance(
                                                                        balance),
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/minus.png",
                                                                width: 18.0,
                                                                height: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 95,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10),
                                                              child: TextField(
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                autofocus: true,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                                onChanged: (value) => balance =
                                                                    int.tryParse(
                                                                            balanceController.text) ??
                                                                        balance,
                                                                onEditingComplete:
                                                                    () => {
                                                                  balance = int.tryParse(
                                                                          balanceController
                                                                              .text) ??
                                                                      balance,
                                                                  Dependencies
                                                                      .instance
                                                                      .saveBalance(
                                                                          balance),
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus(),
                                                                },
                                                                inputFormatters: [
                                                                  LengthLimitingTextInputFormatter(
                                                                    8,
                                                                  ),
                                                                ],
                                                                maxLines: 1,
                                                                controller:
                                                                    balanceController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      "Onest",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 10.0,
                                                              top: 10,
                                                            ),
                                                            child: InkWell(
                                                              onTap: () => {
                                                                setState(
                                                                  () {
                                                                    balance +=
                                                                        1;
                                                                  },
                                                                ),
                                                                Dependencies
                                                                    .instance
                                                                    .saveBalance(
                                                                        balance),
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/plus.png",
                                                                width: 18,
                                                                height: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 43.0),
                                                child: Container(
                                                  height: 20,
                                                  width: 65,
                                                  color: const Color(
                                                    QuotexColors
                                                        .quotexBackgroundCode,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .balance,
                                                      style: const TextStyle(
                                                        fontFamily: "Onest",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color(QuotexColors
                                                            .quotexWhiteCode),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16.0,
                                            ),
                                            child: SmallButton(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .sellButton,
                                              callback: () => {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "${AppLocalizations.of(context)!.tradeWillClose} ${getText()}",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 71, 107, 146),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                                setState(() {
                                                  if ((balance - investment) >=
                                                      0) {
                                                    balance -= investment;
                                                  }
                                                }),
                                                Future.delayed(const Duration(
                                                        seconds: 60))
                                                    .then(
                                                  (value) => {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "${AppLocalizations.of(context)!.tradeWillClose} ${getText()}",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 5,
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              71,
                                                              107,
                                                              146),
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                    setState(
                                                      () {
                                                        double randDouble =
                                                            (Random().nextDouble() -
                                                                    0.5) /
                                                                10;
                                                        var result =
                                                            (randDouble *
                                                                    investment)
                                                                .toInt();
                                                        balance +=
                                                            investment + result;
                                                        Dependencies.instance
                                                            .saveHistory(
                                                          HistoryModel(
                                                            isRed: result < 0,
                                                            resultValue: result
                                                                .toInt()
                                                                .toString(),
                                                            changedPair:
                                                                currTradeValue,
                                                            firstDate: DateFormat(
                                                                    'dd-MM-yyyy HH:mm:ss')
                                                                .format(
                                                              DateTime.now()
                                                                  .add(
                                                                const Duration(
                                                                  seconds: -60,
                                                                ),
                                                              ),
                                                            ),
                                                            secondDate: DateFormat(
                                                                    'dd-MM-yyyy HH:mm:ss')
                                                                .format(
                                                              DateTime.now(),
                                                            ),
                                                          ),
                                                        );
                                                        Dependencies.instance
                                                            .saveBalance(
                                                                balance);
                                                      },
                                                    ),
                                                  },
                                                ),
                                              },
                                              textStyle: const TextStyle(
                                                fontFamily: "Onest",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                              color: const Color(
                                                QuotexColors.quotexWhiteCode,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10.0,
                                                  ),
                                                  child: Container(
                                                    width: 156,
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          QuotexColors
                                                              .quotexBackgroundCode),
                                                      border: Border.all(
                                                        color: const Color(
                                                            QuotexColors
                                                                .quotexGreyTextCode),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10.0,
                                                                top: 10,
                                                              ),
                                                              child: InkWell(
                                                                onTap: () => {
                                                                  setState(
                                                                    () {
                                                                      if (investment >
                                                                          0) {
                                                                        investment -=
                                                                            1;
                                                                      }
                                                                    },
                                                                  )
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  "assets/minus.png",
                                                                  width: 18,
                                                                  height: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 95,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  bottom: 10.0,
                                                                ),
                                                                child:
                                                                    TextField(
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  autofocus:
                                                                      true,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                          border:
                                                                              InputBorder.none),
                                                                  onChanged: (value) =>
                                                                      investment = int
                                                                              .tryParse(
                                                                            investmentController.text.substring(1),
                                                                          ) ??
                                                                          investment,
                                                                  onEditingComplete:
                                                                      () => {
                                                                    investment =
                                                                        int.tryParse(
                                                                              investmentController.text.substring(1),
                                                                            ) ??
                                                                            investment,
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus(),
                                                                  },
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .deny(
                                                                      RegExp(
                                                                          r'^[0-9]'),
                                                                    ),
                                                                    LengthLimitingTextInputFormatter(
                                                                        7),
                                                                  ],
                                                                  maxLines: 1,
                                                                  controller:
                                                                      investmentController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        "Onest",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10.0,
                                                                top: 10.0,
                                                              ),
                                                              child: InkWell(
                                                                onTap: () => {
                                                                  setState(
                                                                    () {
                                                                      investment +=
                                                                          1;
                                                                    },
                                                                  )
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  "assets/plus.png",
                                                                  width: 18.0,
                                                                  height: 18.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 34.0),
                                                  child: Container(
                                                    height: 20.0,
                                                    width: 83.0,
                                                    color: const Color(QuotexColors
                                                        .quotexBackgroundCode),
                                                    child: Center(
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .investment,
                                                        style: const TextStyle(
                                                          fontFamily: "Onest",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(QuotexColors
                                                              .quotexWhiteCode),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 16.0,
                                              ),
                                              child: SmallButton(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .buyButton,
                                                callback: () => {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "${AppLocalizations.of(context)!.tradeWillClose} ${getText()}",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 71, 107, 146),
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                  setState(
                                                    () {
                                                      if ((balance -
                                                              investment) >=
                                                          0) {
                                                        balance -= investment;
                                                      }
                                                    },
                                                  ),
                                                  Future.delayed(const Duration(
                                                          seconds: 60))
                                                      .then(
                                                    (value) => {
                                                      setState(
                                                        () {
                                                          double randDouble =
                                                              (Random().nextDouble() -
                                                                      0.5) /
                                                                  10;
                                                          var result =
                                                              (randDouble *
                                                                      investment)
                                                                  .toInt();
                                                          balance +=
                                                              investment +
                                                                  result;
                                                          Dependencies.instance
                                                              .saveHistory(
                                                            HistoryModel(
                                                              isRed: result < 0,
                                                              resultValue: result
                                                                  .toInt()
                                                                  .toString(),
                                                              changedPair:
                                                                  currTradeValue,
                                                              firstDate: DateFormat(
                                                                      'dd-MM-yyyy HH:mm:ss')
                                                                  .format(
                                                                DateTime.now()
                                                                    .add(
                                                                  const Duration(
                                                                    seconds:
                                                                        -60,
                                                                  ),
                                                                ),
                                                              ),
                                                              secondDate:
                                                                  DateFormat(
                                                                          'dd-MM-yyyy HH:mm:ss')
                                                                      .format(
                                                                DateTime.now(),
                                                              ),
                                                            ),
                                                          );
                                                          Dependencies.instance
                                                              .saveBalance(
                                                                  balance);
                                                        },
                                                      ),
                                                    },
                                                  ),
                                                },
                                                textStyle: const TextStyle(
                                                  fontFamily: "Onest",
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                                color: const Color(QuotexColors
                                                    .quotexGreenCode),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getText() {
    try {
      if (Dependencies.instance.currencies['quotes']
              ['USD${currTradeValue.split('/')[1]}'] !=
          null) {
        return "${(Dependencies.instance.currencies['quotes']['USD${currTradeValue.split('/')[1]}'] ??
        1 / Dependencies.instance.currencies['quotes']['USD${currTradeValue.split('/')[0]}'] ?? 1).toStringAsFixed(4)}";
      } else if (currTradeValue.split('/')[0] == 'USD') {
        return "${(Dependencies.instance.currencies['quotes']['USD${currTradeValue.split('/')[1]}']).toStringAsFixed(4)}";
      } else {
        return (1 /
                Dependencies.instance.currencies['quotes']
                    ['USD${currTradeValue.split('/')[0]}'])
            .toStringAsFixed(4);
      }
    } catch (exception) {
      return "";
    }
  }

  List<List<String>> getTableString(context) {
    return [
      [
        AppLocalizations.of(context)!.eurCad,
        AppLocalizations.of(context)!.eurGbp,
        AppLocalizations.of(context)!.usdJpy,
      ],
      [
        AppLocalizations.of(context)!.audUsd,
        AppLocalizations.of(context)!.eurUsd,
        AppLocalizations.of(context)!.gbpChf,
      ],
      [
        AppLocalizations.of(context)!.gbpUsd,
        AppLocalizations.of(context)!.audJpy,
        AppLocalizations.of(context)!.eurChf,
      ],
      [
        AppLocalizations.of(context)!.usdChf,
        AppLocalizations.of(context)!.nzdUsd,
        AppLocalizations.of(context)!.cadChf,
      ],
      [
        AppLocalizations.of(context)!.usdCad,
        AppLocalizations.of(context)!.cadChf,
        AppLocalizations.of(context)!.eurJpy,
      ],
      [
        AppLocalizations.of(context)!.eurJpy,
        AppLocalizations.of(context)!.cadChf,
        AppLocalizations.of(context)!.usdCad,
      ]
    ];
  }

  _loadHtmlFromAssets() async {
    _webViewController.loadUrl(Uri.dataFromString(htmlData,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  String getHtml(double width, double height, String symbol) {
    return '''
    <!DOCTYPE html>
    <html>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <body bgcolor="#1E2131">
    <!-- TradingView Widget BEGIN -->
    <div class="tradingview-widget-container">
      <div id="tradingview_bdc2c"></div>
      <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/$symbol/?exchange=BITSTAMP" rel="noopener" target="_blank"><span class="blue-text">$symbol Chart</span></a> by TradingView</div>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
      new TradingView.widget(
      {
      "width": $width,
      "height": $height,
      "symbol": "FX:$symbol",
      "interval": "1",
      "timezone": "Etc/UTC",
      "theme": "dark",
      "style": "1",
      "locale": "en",
      "toolbar_bg": "#1E2131",
      "enable_publishing": false,
      "hide_top_toolbar": true,
      "save_image": false,
      "container_id": "tradingview_bdc2c"
    }
      );
      </script>
    </div>
    <!-- TradingView Widget END -->
    </body>
    </html>
    ''';
  }
}
