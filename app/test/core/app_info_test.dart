import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/app_info.dart';

void main() {
  test('AppInfo.version coincide con pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(
      r'^version:\s*([0-9.]+)',
      multiLine: true,
    ).firstMatch(pubspec)!.group(1);
    expect(AppInfo.version, version);
    expect(AppInfo.userAgent, 'Panelsolar/$version');
  });
}
