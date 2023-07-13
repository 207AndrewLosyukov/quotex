import 'package:flutter/material.dart';

class ScannerState {
  final String assetImage;
  final TypeOfTrade typeOfTrade;
  final int buttonChoosedXCoord;
  final int buttonChoosedYCoord;
  final int time;

  ScannerState({
    required this.assetImage,
    required this.typeOfTrade,
    required this.buttonChoosedXCoord,
    required this.buttonChoosedYCoord,
    required this.time
  });
}

enum TypeOfTrade {
  strongSell,
  sell,
  neutral,
  buy,
  strongBuy,
}
