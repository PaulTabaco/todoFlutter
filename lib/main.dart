import 'package:flutter/material.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Test',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      //home: const MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(title: "Main page",),
        '/todo': (context) => const HomePage(title: 'TODO')
      },
    );
  }
}
