import 'package:aliftech_test/bloc/tasks/task_bloc.dart';

import 'package:aliftech_test/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/di_locator.dart';

void main() {
  locatorSetUp();
  runApp(
    BlocProvider(
      create: (context) => TaskBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskBloc>(context).add(TaskInitialEvent());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc pattern demo for AlifTech',
      theme: ThemeData(
        primaryColor: Color(0xFF39b980),
      ),
      home: HomeScreen(),
    );
  }
}
