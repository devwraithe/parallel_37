// // // This is a basic Flutter widget test.
// // //
// // // To perform an interaction with a widget in your test, use the WidgetTester
// // // utility in the flutter_test package. For example, you can send tap and scroll
// // // gestures. You can also use WidgetTester to find child widgets in the widget
// // // tree, read text, and verify that the values of widget properties are correct.

// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:parallel_37/main.dart';

// // void main() {
// //   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
// //     // Build our app and trigger a frame.
// //     await tester.pumpWidget(const Parallel37());

// //     // Verify that our counter starts at 0.
// //     expect(find.text('0'), findsOneWidget);
// //     expect(find.text('1'), findsNothing);

// //     // Tap the '+' icon and trigger a frame.
// //     await tester.tap(find.byIcon(Icons.add));
// //     await tester.pump();

// //     // Verify that our counter has incremented.
// //     expect(find.text('0'), findsNothing);
// //     expect(find.text('1'), findsOneWidget);
// //   });
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:parallel_37/src/presentation/views/widget.dart';

// void main() {
//   // Define a test. The TestWidgets function also provides a WidgetTester
//   // to work with. The WidgetTester allows you to build and interact
//   // with widgets in the test environment.
//   testWidgets('MyWidget has a title and message', (tester) async {
//     // Test code goes here.
//     await tester.pumpWidget(const MaterialApp(
//         home: Scaffold(
//       body: MyWidget(title: "T", message: "M"),
//     )));

//     final titleFinder = find.text("T");
//     final messageFinder = find.text("M");

//     expect(titleFinder, findsOneWidget);
//     expect(messageFinder, findsOneWidget);
//   });
// }
