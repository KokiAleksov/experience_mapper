import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'providers/experience_provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExperienceProvider()),
      ],
      child: Platform.isIOS ? _buildCupertinoApp() : _buildMaterialApp(),
    );
  }

  Widget _buildCupertinoApp() {
    return CupertinoApp(
      title: 'Experience Mapper',
      theme: _buildCupertinoTheme(),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: 'Experience Mapper',
      theme: _buildMaterialTheme(),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  CupertinoThemeData _buildCupertinoTheme() {
    return const CupertinoThemeData(
      primaryColor: CupertinoColors.systemBlue,
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      barBackgroundColor: CupertinoColors.systemBackground,
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.label,
        textStyle: TextStyle(
          color: CupertinoColors.label,
          fontSize: 17,
        ),
        actionTextStyle: TextStyle(
          color: CupertinoColors.systemBlue,
          fontSize: 17,
        ),
        navTitleTextStyle: TextStyle(
          color: CupertinoColors.label,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  ThemeData _buildMaterialTheme() {
    const primaryColor = Color(0xFF6366F1);
    const surfaceColor = Color(0xFFFAFAFA);
    const backgroundColor = Color(0xFFFFFFFF);
    const onSurfaceColor = Color(0xFF1F2937);
    const onBackgroundColor = Color(0xFF111827);

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        background: backgroundColor,
        onBackground: onBackgroundColor,
        error: Color(0xFFEF4444),
        onError: Colors.white,
        outline: Color(0xFFE5E7EB),
        surfaceVariant: Color(0xFFF9FAFB),
        onSurfaceVariant: Color(0xFF6B7280),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: onBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: onBackgroundColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}