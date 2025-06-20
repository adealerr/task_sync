import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/common_pages/profile_page.dart';
import 'package:task_sync/presentation/pages/common_pages/report_page.dart';
import 'package:task_sync/presentation/pages/pages_narrow/chats_narrow_page.dart';
import 'package:task_sync/presentation/pages/pages_narrow/tasks_narrow_page.dart';

class MainNarrowPage extends StatefulWidget {
  const MainNarrowPage({super.key});

  @override
  State<MainNarrowPage> createState() => _MainNarrowPageState();
}

class _MainNarrowPageState extends State<MainNarrowPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TasksNarrowPage(),
    const ChatsNarrowPage(),
    const ProfilePage(),
    const ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: lightPrimary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Отчетность',
          ),
        ],
      ),
    );
  }
}
