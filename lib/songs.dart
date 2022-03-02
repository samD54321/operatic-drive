import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:io';



Future<List<List<dynamic>>> decodeCSV() async {
 final _rawData = await rootBundle.loadString("assets/annotations/songs_info.csv");

 List<List<dynamic>> songs = CsvToListConverter(fieldDelimiter: ',', textDelimiter: '****', eol: '\n').convert(_rawData);

 return songs;

}