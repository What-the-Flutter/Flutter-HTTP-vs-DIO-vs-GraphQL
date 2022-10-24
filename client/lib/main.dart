import 'package:client/presentation/app/app.dart';
import 'package:client/presentation/di/injector.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInjector();
  runApp(App());
}
