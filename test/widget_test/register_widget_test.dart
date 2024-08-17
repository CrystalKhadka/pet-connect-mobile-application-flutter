import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterView Widget Tests', () {
    testWidgets('renders RegisterView and checks form fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the RegisterView is rendered
      expect(find.byType(RegisterView), findsOneWidget);

      // Verify that all form fields are present
      expect(find.byType(TextFormField),
          findsNWidgets(8)); // Adjusted to find 8 fields

      // Verify that the gender selection radio buttons are present
      expect(find.byType(Radio<String>),
          findsNWidgets(2)); // Male and Female radio buttons
    });

    testWidgets('test form validation and submission', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Clear the pre-filled form fields to trigger validation errors
      await tester.enterText(find.byType(TextFormField).at(0), '');
      await tester.enterText(find.byType(TextFormField).at(1), '');
      await tester.enterText(find.byType(TextFormField).at(2), '');
      await tester.enterText(find.byType(TextFormField).at(3), '');
      await tester.enterText(find.byType(TextFormField).at(4), '');
      await tester.enterText(find.byType(TextFormField).at(5), '');
      await tester.enterText(find.byType(TextFormField).at(6), '');

      // Verify that the Sign Up button is present and scroll into view
      final buttonFinder = find.byType(MyButton);
      await tester.ensureVisible(buttonFinder);

      // Tap on the Sign Up button
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Check for specific validation errors, using .first to avoid multiple instances
      expect(find.text('Please enter your first name').first, findsOneWidget);
      expect(find.text('Please enter your last name').first, findsOneWidget);
      expect(find.text('Please enter your email').first, findsOneWidget);
      expect(find.text('Please enter your password').first, findsOneWidget);
    });
  });
}
