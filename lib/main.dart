import 'package:coach_hub/core/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/dark_mode.dart';
import 'features/home/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider to use the theme mode
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event App',
      themeMode:
          themeProvider.themeMode, // Applying themeMode from ThemeProvider
      theme: ThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[850],
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey[400],
        ),
      ),
      home: HomePage(),
    );
  }
}
