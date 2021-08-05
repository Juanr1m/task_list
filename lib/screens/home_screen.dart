import 'package:flutter/material.dart';

import 'all_task_screen.dart';

import 'done_task_screen.dart';
import 'progress_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [
    AllTaskScreen(),
    ProcessTaskScreen(),
    DoneTaskScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                label: "Все", icon: Icon(Icons.calendar_today)),
            BottomNavigationBarItem(
                label: "В прогрессе", icon: Icon(Icons.refresh)),
            BottomNavigationBarItem(label: "Выполнено", icon: Icon(Icons.done)),
          ],
          currentIndex: selectedIndex,
          onTap: onTap,
        ),
        body: pages[selectedIndex]);
  }

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
