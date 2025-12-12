import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/screens/login_screen.dart';

void main() {
  testWidgets('LoginScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Don\'t have an account? Register'), findsOneWidget);
  });

  testWidgets('LoginScreen form validation works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Try to submit empty form
    final loginButton = find.text('Login');
    await tester.tap(loginButton);
    await tester.pump();

    // Form should show validation errors
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });
}

