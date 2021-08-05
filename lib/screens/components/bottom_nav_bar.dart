import 'package:agrobank_test/bloc/bottom_navigation/bottomnavigation_bloc.dart';
import 'package:agrobank_test/bloc/bottom_navigation/bottomnavigation_event.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required BottomnavigationBloc? navbarBloc,
    required this.currentIndex,
  })  : _navbarBloc = navbarBloc,
        super(key: key);

  final BottomnavigationBloc? _navbarBloc;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) _navbarBloc!.add(NavbarItems.All);
        if (index == 1) _navbarBloc!.add(NavbarItems.Progress);
        if (index == 2) _navbarBloc!.add(NavbarItems.Done);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Все',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.refresh),
          label: 'В прогрессе',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Выполнено',
        ),
      ],
    );
  }
}
