import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chatlar/core/di/injection.dart';
import 'package:chatlar/main.dart';

void main() {
  setUpAll(() async {
    await init();
  });

  testWidgets('App builds and shows login or home', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatlarApp());
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
