import 'package:flutter/material.dart';
import 'package:rasseni_api/controller/app_user.dart';
import 'package:provider/provider.dart';
import 'package:rasseni_api/view/choose_courses.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppUser(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCourses(),
    );
  }
}
