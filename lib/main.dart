import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moovlah_driver/Screens/wrapper.dart';
import 'package:provider/provider.dart';

import 'Models/models.dart';
import 'Models/registerModel.dart';
import 'Service/auth.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeNotifierProvider(
      create: (context) => Register(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamProvider<UserAuth?>.value(
          value: AuthServices().user,
          initialData: null,
          child: const Wrapper(),
        ),
      ),
    );
  }
}
