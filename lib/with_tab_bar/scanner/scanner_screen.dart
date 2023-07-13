import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_button.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_cubit.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final ScannerCubit cubit;

  late List<List<String>> table = [
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

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of(context);
    cubit.getRandomState(1, 0);
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        if (cubit.state.time > 0) {
          cubit.setTime(cubit.state.time - 1);
        } else {
          cubit.setTime(59);
          cubit.updateRandArray();
          cubit.getRandomState(
            cubit.state.buttonChoosedXCoord,
            cubit.state.buttonChoosedYCoord,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 41.0),
                child: Text(
                  AppLocalizations.of(context)!.trendRadar,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w700,
                    color: Color(QuotexColors.quotexWhiteCode),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 41.0),
                child: BlocBuilder<ScannerCubit, ScannerState>(
                    builder: (context, state) {
                  return Image.asset(
                    state.assetImage,
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.timeToUpdate,
                                  style: const TextStyle(
                                    fontFamily: "Onest",
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Color(QuotexColors.quotexGreyTextCode),
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                      top: 7,
                                    ),
                                    child:
                                        BlocBuilder<ScannerCubit, ScannerState>(
                                            builder: (context, state) {
                                      return Text(
                                        state.time > 9
                                            ? "00:${state.time}"
                                            : "00:0${state.time}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: "Onest",
                                          fontWeight: FontWeight.w700,
                                          color: Color(
                                              QuotexColors.quotexWhiteCode),
                                          fontSize: 16,
                                        ),
                                      );
                                    })),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 49,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF2A2D3E),
                                Color(0xFF30365B),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.tradingPair,
                                  style: const TextStyle(
                                    fontFamily: "Onest",
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Color(QuotexColors.quotexGreyTextCode),
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 7,
                                  ),
                                  child:
                                      BlocBuilder<ScannerCubit, ScannerState>(
                                          builder: (context, state) {
                                    return Text(
                                      cubit.getTrendString(context),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Onest",
                                        fontWeight: FontWeight.w700,
                                        color: cubit.getTrendColor(),
                                        fontSize: 16,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 49,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF2A2D3E),
                                Color(0xFF30365B),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tradingPair,
                            style: const TextStyle(
                              fontFamily: "Onest",
                              fontWeight: FontWeight.w400,
                              color: Color(QuotexColors.quotexGreyTextCode),
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 7,
                            ),
                            child: BlocBuilder<ScannerCubit, ScannerState>(
                                builder: (context, state) {
                              return Text(
                                table[state.buttonChoosedYCoord]
                                    [state.buttonChoosedXCoord],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: "Onest",
                                  fontWeight: FontWeight.w700,
                                  color: Color(QuotexColors.quotexWhiteCode),
                                  fontSize: 16,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
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
                          child: BlocBuilder<ScannerCubit, ScannerState>(
                            builder: (context, state) {
                              return ScannerButton(
                                activeButtonColor: const Color(
                                    QuotexColors.quotexActiveButtonCode),
                                text: table[index][0],
                                callback: () => {
                                  cubit.getRandomState(0, index),
                                },
                                isActive: state.buttonChoosedXCoord == 0 &&
                                        state.buttonChoosedYCoord == index
                                    ? true
                                    : false,
                              );
                            },
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          flex: 22,
                          child: BlocBuilder<ScannerCubit, ScannerState>(
                            builder: (context, state) {
                              return ScannerButton(
                                activeButtonColor: const Color(
                                    QuotexColors.quotexActiveButtonCode),
                                text: table[index][1],
                                callback: () => {
                                  cubit.getRandomState(1, index),
                                },
                                isActive: state.buttonChoosedXCoord == 1 &&
                                        state.buttonChoosedYCoord == index
                                    ? true
                                    : false,
                              );
                            },
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          flex: 22,
                          child: BlocBuilder<ScannerCubit, ScannerState>(
                            builder: (context, state) {
                              return ScannerButton(
                                activeButtonColor: const Color(
                                    QuotexColors.quotexActiveButtonCode),
                                text: table[index][2],
                                callback: () => {
                                  cubit.getRandomState(2, index),
                                },
                                isActive: state.buttonChoosedXCoord == 2 &&
                                        state.buttonChoosedYCoord == index
                                    ? true
                                    : false,
                              );
                            },
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
