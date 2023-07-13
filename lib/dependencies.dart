import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotex/navigator.dart';
import 'package:quotex/with_tab_bar/history/history_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dependencies {
  final AppNavigator navigator;

  List<HistoryModel> newCells = [];

  static late Dependencies _instance;

  final httpString =
      "http://api.apilayer.com/currency_data/live?currencies=EUR,AUD,GBP,CAD,JPY,NZD,CHF&apikey=7iSAZnQwybriQ7lj6z2vSAJLvftqxORo";

  Map<String, dynamic> currencies = <String, dynamic>{};

  Future<Map<String, dynamic>> getHttpCurrencies() async {
    try {
      var response = await http.get(Uri.parse(
        httpString,
      ));
      currencies = jsonDecode(response.body);
    } catch (exception) {}
    return currencies;
  }

  Dependencies._(
    this.navigator,
  );

  static Dependencies init() {
    return _instance = Dependencies._(
      AppNavigator(),
    );
  }

  List<HistoryModel> openHistory() {
    var box = Hive.box('history');
    var values = box.values.map((e) => e as HistoryModel).toList();
    return values;
  }

  void saveHistory(HistoryModel model) {
    var box = Hive.box('history');
    newCells.add(model);
    box.add(model);
  }

  void saveBalance(int balance) {
    var box = Hive.box('balance');
    box.put('balance', balance);
  }

  Future<int> getBalance() async {
    var box = Hive.box('balance');
    return await box.get('balance') ?? 10000;
  }

  static Dependencies get instance => _instance;
}
