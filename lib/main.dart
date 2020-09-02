import 'package:HyChat/screens/home_screen.dart';
import 'package:flutter/material.dart';

final primaryColor = Color(0xFF7085E2);
final accentColor = Color(0xFFE8EDF5);
final MaterialColor swatchColor = MaterialColor(
  primaryColor.value,
  {
    50: primaryColor.withOpacity(0.1),
    100: primaryColor.withOpacity(0.2),
    200: primaryColor.withOpacity(0.3),
    300: primaryColor.withOpacity(0.4),
    400: primaryColor.withOpacity(0.5),
    500: primaryColor.withOpacity(0.6),
    600: primaryColor.withOpacity(0.7),
    700: primaryColor.withOpacity(0.8),
    800: primaryColor.withOpacity(0.9),
    900: primaryColor.withOpacity(1.0),
  },
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hy Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: swatchColor,
        accentColor: accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

// 0xFF3550C7
// 0xFF1621E5
// 0xFFF5F7FB
// 0xFFDCE3E9
