import 'dart:async';
import 'package:fire/fire.dart';

void main() {
  final fire = new Fire();
  new Timer.periodic(const Duration(milliseconds: 30), (timer) => fire.draw());
}
