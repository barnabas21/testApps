import 'package:flutter/material.dart';
import 'package:testappmobile/views/login.dart';
import 'package:testappmobile/views/profileIndex.dart';
import 'package:testappmobile/views/register.dart';
import 'views/homepage.dart';

class MyApp extends StatelessWidget {
  final String title;
  const MyApp({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TESTAPP',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'TESTAPP'),
        '/login': (context) => const Login(title: 'TESTAPP'),
        '/register': (context) => const Register(title: 'TESTAPP'),
        '/profile': (context) => const ProfileIndex(title: 'TESTAPP', userdata: {}, usernme: '',),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}