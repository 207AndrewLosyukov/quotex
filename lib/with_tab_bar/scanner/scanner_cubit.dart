import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/with_tab_bar/scanner/scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  static final Random _random = Random(DateTime.now().microsecond % 10000);

  var _randArray = [
    [
      _random.nextInt(5),
      _random.nextInt(5),
      _random.nextInt(5),
    ],
    [
      _random.nextInt(5),
      _random.nextInt(5),
      _random.nextInt(5),
    ],
    [
      _random.nextInt(5),
      _random.nextInt(5),
      _random.nextInt(5),
    ],
    [
      _random.nextInt(5),
      _random.nextInt(5),
      _random.nextInt(5),
    ],
    [
      _random.nextInt(5),
      _random.nextInt(5),
      _random.nextInt(5),
    ],
    [
      _random.nextInt(5),
      _random.nextInt(5),
      _random.nextInt(5),
    ]
  ];

  ScannerCubit(context)
      : super(ScannerState(
          assetImage: "",
          typeOfTrade: TypeOfTrade.buy,
          buttonChoosedXCoord: 1,
          buttonChoosedYCoord: 0,
          time: 59,
        ));

  void updateRandArray() {
    _randArray = [
      [
        _random.nextInt(5),
        _random.nextInt(5),
        _random.nextInt(5),
      ],
      [
        _random.nextInt(5),
        _random.nextInt(5),
        _random.nextInt(5),
      ],
      [
        _random.nextInt(5),
        _random.nextInt(5),
        _random.nextInt(5),
      ],
      [
        _random.nextInt(5),
        _random.nextInt(5),
        _random.nextInt(5),
      ],
      [
        _random.nextInt(5),
        _random.nextInt(5),
        _random.nextInt(5),
      ],
      [
        _random.nextInt(5),
        _random.nextInt(5),
        _random.nextInt(5),
      ]
    ];
  }

  void getRandomState(int x, int y) {
    int value = _randArray[y][x];
    switch (value) {
      case 0:
        _setStrongSellState(x, y);
        break;
      case 1:
        _setSellState(x, y);
        break;
      case 2:
        _setNeutralState(x, y);
        break;
      case 3:
        _setBuyState(x, y);
        break;
      case 4:
        _setStrongBuyState(x, y);
        break;
      default:
        break;
    }
  }

  void _setStrongSellState(int x, int y) {
    emit(ScannerState(
      assetImage: "assets/strong_sell.png",
      typeOfTrade: TypeOfTrade.strongSell,
      buttonChoosedXCoord: x,
      buttonChoosedYCoord: y,
      time: state.time,
    ));
  }

  void _setSellState(int x, int y) {
    emit(ScannerState(
      assetImage: "assets/sell.png",
      typeOfTrade: TypeOfTrade.sell,
      buttonChoosedXCoord: x,
      buttonChoosedYCoord: y,
      time: state.time,
    ));
  }

  void _setNeutralState(int x, int y) {
    emit(ScannerState(
      assetImage: "assets/neutral.png",
      typeOfTrade: TypeOfTrade.neutral,
      buttonChoosedXCoord: x,
      buttonChoosedYCoord: y,
      time: state.time,
    ));
  }

  void _setBuyState(int x, int y) {
    emit(ScannerState(
      assetImage: "assets/buy.png",
      typeOfTrade: TypeOfTrade.buy,
      buttonChoosedXCoord: x,
      buttonChoosedYCoord: y,
      time: state.time,
    ));
  }

  void _setStrongBuyState(int x, int y) {
    emit(ScannerState(
      assetImage: "assets/strong_buy.png",
      typeOfTrade: TypeOfTrade.strongBuy,
      buttonChoosedXCoord: x,
      buttonChoosedYCoord: y,
      time: state.time,
    ));
  }

  String getTrendString(context) {
    switch (state.typeOfTrade) {
      case TypeOfTrade.strongSell:
        return AppLocalizations.of(context)!.strongSell;
      case TypeOfTrade.sell:
        return AppLocalizations.of(context)!.sell;
      case TypeOfTrade.neutral:
        return AppLocalizations.of(context)!.neutral;
      case TypeOfTrade.buy:
        return AppLocalizations.of(context)!.buy;
      case TypeOfTrade.strongBuy:
        return AppLocalizations.of(context)!.strongBuy;
    }
  }

  Color getTrendColor() {
    switch (state.typeOfTrade) {
      case TypeOfTrade.strongSell:
        return const Color(0xFFF82F39);
      case TypeOfTrade.sell:
        return const Color(0xFFF82F39);
      case TypeOfTrade.neutral:
        return const Color(0xFF747788);
      case TypeOfTrade.buy:
        return const Color(0xFF51BC74);
      case TypeOfTrade.strongBuy:
        return const Color(0xFF51BC74);
    }
  }

  setTime(int time) {
    emit(ScannerState(
      assetImage: state.assetImage,
      typeOfTrade: state.typeOfTrade,
      buttonChoosedXCoord: state.buttonChoosedXCoord,
      buttonChoosedYCoord: state.buttonChoosedYCoord,
      time: time,
    ));
  }
}
