import 'package:conceptualize/app.dart';
import 'package:conceptualize/di/di.dart';
import 'package:flutter/material.dart';

void main() {
  final baseDi = BaseDi();
  baseDi.setUp();
  runApp(const MyApp());
}
