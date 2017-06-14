import 'dart:async';
import 'package:fire/fire.dart';

void main() {
  final canvas = document.querySelector('canvas');
  final fire = new Fire(canvas);
  new Timer.periodic(const Duration(milliseconds: 30), (timer) => fire.draw());
}
