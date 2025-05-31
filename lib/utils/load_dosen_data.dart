import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:whazlansaja/screen/model/dosen_model.dart';

Future<List<DosenModel>> loadDosenJson() async {
  final String response =
      await rootBundle.loadString('assets/data/dosen_chat.json');
  final data = await json.decode(response) as List;

  return data.map((json) => DosenModel.fromJson(json)).toList();
}
