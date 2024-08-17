import 'package:final_assignment/features/forgot_password/presentation/view/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders ForgotPasswordView and checks form fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ForgotPasswordView(),
        ),
      ),
    );

    // Check that the title is displayed
    expect(find.text('Forgot Password'), findsOneWidget);

    // Check that the option buttons are displayed
    expect(find.widgetWithText(ElevatedButton, 'Email'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Phone'), findsOneWidget);

    // Initially, the email form field should be visible
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);

    // Tap on the 'Phone' option
    await tester.tap(find.widgetWithText(ElevatedButton, 'Phone'));
    await tester.pumpAndSettle();

    // Check that the phone field is now visible and email is not
    expect(find.widgetWithText(TextFormField, 'Phone'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Email'), findsNothing);

    // Check that OTP and password fields are not visible initially
    expect(find.widgetWithText(TextFormField, 'OTP'), findsNothing);
    expect(find.widgetWithText(TextFormField, 'New Password'), findsNothing);
    expect(
        find.widgetWithText(TextFormField, 'Confirm Password'), findsNothing);
  });
}
