import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/common_pages/login_page.dart';
import 'package:task_sync/presentation/pages/pages_narrow/main_narrow_page.dart';
import 'package:task_sync/utils/platform_helper.dart';

import 'presentation/pages/pages_wide/main_wide_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',
      theme: ThemeData(
        primaryColor: lightPrimary,
        scaffoldBackgroundColor: lightBackground,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: lightText),
          bodyMedium: TextStyle(color: lightTextMuted),
        ),
      ),
      // home: ChatterHome(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        // '/': (context) => const MainWidePage(),
        // '/': (context) => const MainNarrowPage(),
        // '/': (context) => const MainNarrowPage(),
        // '/': (context) => ChatterHome(),
        // '/login': (context) => ChatterLogin(),
        // '/signup': (context) => ChatterSignUp(),
        // '/chat': (context) => ChatterScreen(),
        // '/chats':(context)=>ChatterScreen()
      },
    );
  }
}
