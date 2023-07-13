import 'package:flutter/material.dart';
import 'package:quotex/dependencies.dart';
import 'package:quotex/quotex_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quotex/with_tab_bar/history/history_cell.dart';
import 'package:quotex/with_tab_bar/history/history_model.dart';

class HistoryScreen extends StatefulWidget {
  // Сделал конструктор без key для пересоздания State, чтобы подгружались новые ячейки при переключении tab
  HistoryScreen();

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<HistoryModel> cells;

  @override
  Widget build(BuildContext context) {
    // Подгрузка ячеек
    cells = Dependencies.instance.openHistory().reversed.toList();
    return Scaffold(
      backgroundColor: const Color(QuotexColors.quotexBackgroundCode),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 41.0),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.historyTitle,
              style: const TextStyle(
                fontFamily: "Onest",
                fontWeight: FontWeight.w700,
                color: Color(QuotexColors.quotexWhiteCode),
                fontSize: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 41.0, left: 16, right: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.instrumentIP,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w400,
                    color: Color(QuotexColors.quotexHistoryGreyCode),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.result,
                  style: const TextStyle(
                    fontFamily: "Onest",
                    fontWeight: FontWeight.w400,
                    color: Color(QuotexColors.quotexHistoryGreyCode),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
          color: Color(
            QuotexColors.quotexHistoryGreyCode,
          ),
        ),
        // Массив данных с историями
        SizedBox(
          height: MediaQuery.of(context).size.height - 230,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: cells.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  HistoryCell(
                    isRed: cells[index].isRed,
                    resultValue: "${cells[index].resultValue}\$",
                    changedPair: cells[index].changedPair,
                    firstDate: cells[index].firstDate,
                    secondDate: cells[index].secondDate,
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                    color: Color(
                      QuotexColors.quotexHistoryGreyCode,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
