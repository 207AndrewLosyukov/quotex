import 'package:flutter/material.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryCell extends StatelessWidget {
  bool isRed;
  String resultValue;
  String changedPair;
  String firstDate;
  String secondDate;

  HistoryCell({
    super.key,
    required this.isRed,
    required this.resultValue,
    required this.changedPair,
    required this.firstDate,
    required this.secondDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 125,
      color: const Color(QuotexColors.quotexBackgroundCode),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  changedPair,
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
                  Text(
                    resultValue,
                    style: TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w500,
                      color: isRed
                          ? const Color(QuotexColors.quotexRedCode)
                          : const Color(QuotexColors.quotexGreenCode),
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      isRed ? "assets/red_arrow.png" : "assets/green_arrow.png",
                      width: 15.58,
                      height: 11.15,
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.quotationOpening,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w400,
                      color: Color(QuotexColors.quotexHistoryGreyCode),
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    firstDate,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w400,
                      color: Color(QuotexColors.quotexWhiteCode),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.quotationClosing,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w400,
                      color: Color(QuotexColors.quotexHistoryGreyCode),
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    secondDate,
                    style: const TextStyle(
                      fontFamily: "Onest",
                      fontWeight: FontWeight.w400,
                      color: Color(QuotexColors.quotexWhiteCode),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
