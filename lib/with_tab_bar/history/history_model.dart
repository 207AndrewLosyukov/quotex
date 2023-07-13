import 'package:hive_flutter/hive_flutter.dart';

part 'history_model.g.dart';

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  bool isRed;
  @HiveField(1)
  String resultValue;
  @HiveField(2)
  String changedPair;
  @HiveField(3)
  String firstDate;
  @HiveField(4)
  String secondDate;

  HistoryModel(
      {required this.isRed,
      required this.resultValue,
      required this.changedPair,
      required this.firstDate,
      required this.secondDate});
}
