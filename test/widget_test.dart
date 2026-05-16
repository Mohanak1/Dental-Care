import 'package:flutter_test/flutter_test.dart';

import 'package:dental_care/app.dart';

void main() {
  testWidgets('DentalCare app renders splash screen', (tester) async {
    await tester.pumpWidget(const DentalCareApp());

    expect(find.text('DentalCare'), findsOneWidget);
    expect(find.text('Clinic appointments made simple'), findsOneWidget);
  });
}
