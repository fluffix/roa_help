import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:roa_help/Requests/Stats/StatsSerialise.dart';
import 'package:roa_help/main.dart';

Future<StatsSerialise> getStats({@required String token, String date}) async {
  try {
    final String url =
        date != null ? '$apiURL/stats?date=$date' : '$apiURL/stats';
    log(url);
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': "application/json",
        'Authorization': "Bearer $token",
      },
    );
    Map<String, dynamic> jsonMap = json.decode(response.body);
    StatsSerialise db = StatsSerialise.fromJson(jsonMap);

    return db;
  } catch (e) {
    print(e);
    return null;
  }
}
