import 'package:flutter_test/flutter_test.dart';

import 'package:goang_driver/driver_app/main.dart';

void main() {
  testWidgets('Driver app smoke test', (WidgetTester tester) async {
    // Ganti MyApp() menjadi GoAngDriverApp()
    await tester.pumpWidget(const GoAngDriverApp());

    // Contoh assertion awal—sesuaikan kalau perlu:
    expect(find.text('Register Driver'), findsOneWidget);
  });
}
